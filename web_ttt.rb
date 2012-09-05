require "sinatra"
require "ang_ttt_gem"
require "game"
require "validate"

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
    @game = Game.new
    create_player(type_1, mark_1)
    create_player(type_2, mark_2)-
    player_1_move = get_move(1)
    if player_1_move == false
      @state = @game.prepare_display_state
      erb :board
    else
      @state = @game.make_move_player(1, player_1_move)
      erb :board
    end
    #@state = %w( X O X O X O X X X )
  end
    #    end_game
    #    start_the_game unless !play_again?
end

post '/board' do
  cell_number = params[:cell]
   erb :board if @game.square_taken?(cell_number)
  cell_number
end

# get '/testboard' do
#   @state = %w( X O X O X O X X X )
#   erb :board
# end

 # 
 #  def end_game
 #    result = @game.result
 #    @ui.display_message(result)
 #  end
  
  def create_player(type, mark)
    @game.create_human_player(mark) if type == "human"
    @game.create_computer_player(mark) if type == "computer"
  end
  
  def get_move(player)
    move = @game.get_player_move(player)
    move
  end
  
  def get_human_move
    cell_number = params[:cell]
    while @game.square_taken?(cell_number)
      erb :board
    end
    cell_number
  end
  

  # 
  # def play_again?
  #   @ui.display_message(:play_again?)
  #   choice = @ui.read_input
  #   while !@validate.play_again_input(choice)
  #     @ui.display_message(:invalid_selection, :play_again?)
  #     choice = @ui.read_input
  #   end
  #   choice = choice.upcase
  #   return false if choice == "N"
  #   return true if choice == "Y"
  # end
