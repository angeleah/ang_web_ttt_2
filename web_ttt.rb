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
    @state, @message = messenger.ai_move_if_possible
    erb :board
  else
    erb :index
  end
end

post '/board' do
  messenger = Messenger.new
  if !messenger.valid_move?(params[:cell].to_i)
    erb :board
  elsif messenger.valid_move?(params[:cell].to_i)
    @state, @message = messenger.human_move(params[:cell].to_i)
    erb :board
  end
end