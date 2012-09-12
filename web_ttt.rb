$: << File.expand_path(File.dirname(__FILE__))
require "sinatra"
require "pry"
require "ang_ttt_gem"
require "validate"
require "game"
require "game_repository"
require "messenger"

get '/' do
 erb :index
end

get '/start_over' do
  erb :index
end

get '/quit' do
  erb :quit
end

post '/' do
  messenger = Messenger.new
  if messenger.set_up_game(params[:player_1_type], params[:player_1_mark], params[:player_2_type], params[:player_2_mark])
    @state = messenger.decide_on_action
    #@message = @game.result if @game.is_over?
    erb :board
  else
    erb :index
  end
end

post '/board' do
  if !messenger.valid_move(params[:cell].to_i)
    erb :board
  elsif messenger.valid_move(params[:cell].to_i)
    @state = messenger.decide_on_action
    @game.make_move_player(@player, cell_number)
    switch_turn
    data = prepare_hash_for_storage
    save_game_state(data)
    if game.is_over?
      gather_board_state
    else
      computer_move
    end
  end
#  @message = @game.result if @game.is_over?
    erb :board      #if there is a winner disable all clicks
end