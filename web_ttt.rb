$: << File.expand_path(File.dirname(__FILE__))
require "sinatra"
require "ang_ttt_gem"
require "validate"
require "game"
require "game_repository"
require "messenger"

get '/' do
 erb :index
end

get '/start_over' do
  @messenger = Messenger.new((params[:game_id]))
  @messenger.delete_game_file unless (params[:game_id]).nil?
  erb :index
end

get '/quit' do
  @messenger = Messenger.new((params[:game_id]))
  @messenger.delete_game_file unless (params[:game_id]).nil?
  erb :quit
end

post '/' do
  @messenger = Messenger.new
  if @messenger.set_up_game(params[:player_1_type], params[:player_1_mark], params[:player_2_type], params[:player_2_mark])
    @state, @message = @messenger.ai_move_if_possible
    @game_id = @messenger.game_id
    erb :board
  else
    erb :index
  end
end

post '/board' do
  @messenger = Messenger.new(params[:game_id])
  @game_id = @messenger.game_id
  if @messenger.valid_move?(params[:cell].to_i) == false
    @state = @messenger.gather_board_state
    erb :board
  elsif @messenger.valid_move?(params[:cell].to_i)
    @state, @message = @messenger.human_move(params[:cell].to_i)
    erb :board
  end
end
