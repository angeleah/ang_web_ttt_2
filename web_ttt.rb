$: << File.expand_path(File.dirname(__FILE__))
require "sinatra"
require "pry"
require "ang_ttt_gem"
require "validate"
require "game"
require "game_repository"


get '/' do
 erb :index
end

post '/' do
  @validate = Validate.new
  @type_1 = params[:player_1_type]
  @mark_1 = params[:player_1_mark].upcase
  @type_2 = params[:player_2_type]
  @mark_2 = params[:player_2_mark].upcase
  if !@validate.mark_input(@mark_1)
    erb :index
  elsif !@validate.mark_input(@mark_2)
    erb :index
  else
    @game = Game.new
    create_player(@type_1, @mark_1)
    create_player(@type_2, @mark_2)
    @player = 1
    player_move = get_move(@player)
    if player_move == false
      @state = @game.gather_board_state
      data = prepare_hash_for_storage
      save_game_state(data)
      erb :board
    else
      @game.make_move_player(@player, player_move)
      @state = @game.gather_board_state
      switch_turn
      data = prepare_hash_for_storage
      save_game_state(data)
      erb :board
    end
   end
end
#
def prepare_hash_for_storage
  {
    :type_1 => @type_1,
    :mark_1 => @mark_1,
    :type_2 => @type_2,
    :mark_2 => @mark_2,
    :turn => @player,
    :board_state => @game.gather_board_state
  }
end
#
def save_game_state(data)
  @game_repository = GameRepository.new
  @game_repository.save(data)
end
#
def load_game_state
  @game_repository = GameRepository.new
  @game_repository.load
end
#
def reconstruct_game
  @data = load_game_state
  @type_1 = @data[:type_1]
  @mark_1 = @data[:type_2]
  @type_2 = @data[:mark_1]
  @mark_2 = @data[:type_1]
  @player = @data[:turn]
  @board_state = @data[:board_state]
  @game = Game.new
  create_player(@type_1, @mark_1)
  create_player(@type_2, @mark_2)
  populate_board(@board_state)
end
#
def populate_board(board_state)
  @board_state.each_with_index{ |i, index|
    @game.make_move(index,i)
  }
end

def switch_turn
   @player == 1 ? @player = 2 : @player = 1
end

post '/board' do
  binding.pry
  reconstruct_game
  cell_number = params[:cell].to_i
  if @game.square_taken?(cell_number)  # change this to diable click if taken  ## this is returning true when should be false. oops! maybe the gem is not updated properly.
    #my console gem is version dependent and I did not update.  Also didn't re bundle.
    @state = @game.gather_board_state
    data = prepare_hash_for_storage
    save_game_state(data)
    erb :board
  else
    player_move = get_move(@player)
    if player_move == false
       @state = @game.gather_board_state
       data = prepare_hash_for_storage
       save_game_state(data)
       erb :board
    else
      @game.make_move_player(@player, player_move)
      @state = @game.gather_board_state
      switch_turn
      data = prepare_hash_for_storage
      save_game_state(data)
      erb :board
    end
  end
end

# get '/testboard' do
#   @state = %w( X O X O X O X X X )
#   erb :board
# end

  def create_player(type, mark)
    @game.create_human_player(mark) if type == "human"
    @game.create_computer_player(mark) if type == "computer"
  end

  def get_move(player)
    move = @game.get_player_move(player)
    move
  end