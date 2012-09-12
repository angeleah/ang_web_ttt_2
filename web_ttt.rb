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
  messenger.set_up_game(params[:player_1_type], params[:player_1_mark], params[:player_2_type], params[:player_2_mark]) == true ? @state = messenger.decide_on_action : (erb :index)
  @message = @game.result if @game.is_over?
  erb :board
end

post '/board' do
  messenger.reconstruct_game
  cell_number = params[:cell].to_i
  player_move = get_move(@player)
  erb :board if !messenger.valid_move?
  if @game.square_taken?(cell_number)
    @state = @game.gather_board_state
    data = prepare_hash_for_storage
    save_game_state(data)
  
  else
    @game.make_move_player(@player, cell_number)
    @state = @game.gather_board_state
    switch_turn
    data = prepare_hash_for_storage
    save_game_state(data)
  end
  computer_move
  @message = @game.result if @game.is_over?
  erb :board      #if there is a winner disable all clicks
end