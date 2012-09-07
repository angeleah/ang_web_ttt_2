require "sinatra"
require "ang_ttt_gem"
require "validate"
require "game"

get '/' do
 erb :index
end

post '/' do
  @validate = Validate.new
  type_1 = params[:player_1_type]
  mark_1 = params[:player_1_mark].upcase
  type_2 = params[:player_2_type]
  mark_2 = params[:player_2_mark].upcase
  if !@validate.mark_input(mark_1)
    erb :index
  elsif !@validate.mark_input(mark_2)
    erb :index
  else
    create_player(type_1, mark_1)
    create_player(type_2, mark_2)
    @player = 1
    player_1_move = get_move(@player)
    if player_1_move == false
      @state = game.prepare_display_state
      erb :board
    else
      @state = game.make_move_player(@player, player_1_move)
      switch_turn
      erb :board
    end
  end
end

def switch_turn
   @player == 1 ? @player = 2 : @player = 1
end

post '/board' do
  cell_number = params[:cell]
  player = params[:player].to_i
  erb :board if game.square_taken?(cell_number)
  @state = game.make_move_player(player, cell_number)
  player = switch_turn
  move = get_move(player)
  if move == false
    erb :board
  else
    @state = game.make_move_player(player, move)
    switch_turn
    erb :board
  end
end

# get '/testboard' do
#   @state = %w( X O X O X O X X X )
#   erb :board
# end
  
  def create_player(type, mark)
    game.create_human_player(mark) if type == "human"
    game.create_computer_player(mark) if type == "computer"
  end
  
  def get_move(player)
    move = game.get_player_move(player)
    move
  end