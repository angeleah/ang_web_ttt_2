# require 'spec_helper'
# require 'web_ttt'
# require "ang_ttt_gem"
# require "game_repository"
# require "messenger"
# 
# set :environment, :test
# 
# def app
#   Sinatra::Application
# end
# 
# describe 'ang_web_ttt_2' do
#   include Rack::Test::Methods
#   
#   it 'should get a computer_move' do
#     
#   end
# 
#   describe 'rendering pages' do
#     it 'should should load the homepage' do
#       get '/'
#       last_response.should be_ok
#     end
# 
#     it 'should load /start_over' do
#       get '/start_over'
#       last_response.should be_ok
#     end
# 
#     it 'should load the quit page' do
#       get '/quit'
#       last_response.should be_ok
#     end
# 
#     it 'should render the homepage if the params are invalid' do
#       post "/", :player_1_type=> "human", :player_1_mark => "x", :player_2_type => "computer", :player_2_mark => "7"
#       last_response.body.include?('Welcome to Tic-Tac-Toe')
#     end
# 
#     it 'should render the board if the params are valid' do
#       post "/", :player_1_type=> "human", :player_1_mark => "x", :player_2_type => "computer", :player_2_mark => "w"
#       last_response.body.include?("<td></td>")
#     end
#   end
# 
#     it 'should be able to save a game state' do
#       save_game_state(game_data)
#       File.read("./state_machine.yml").should include("human", "computer", "A", "P", " ", "1")
#     end
# 
#     it 'should be able to load the game state' do
#       save_game_state(game_data)
#       @fetched_data = load_game_state
#       @fetched_data.should == 
#       {
#         :type_1 => "human",
#         :mark_1 => "A",
#         :type_2 => "computer",
#         :mark_2 => "P",
#         :turn => 1,
#         :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " "]
#       }
#     end
# 
#     it 'should be able to reconstruct a game' do
#       reconstruct_game
#       @type_1.should == @data[:type_1]
#       @mark_1.should == @data[:mark_1]
#       @type_2.should == @data[:type_2]
#       @mark_2.should == @data[:mark_2]
#       @player.should == @data[:turn]
#       @board_state.should == @data[:board_state]
#       @game.players.count.should == 2
#     end
# 
#     it 'should be able to populate a board' do
#       @game = Game.new
#       board_state = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
#       populate_board(board_state)
#       @game.gather_board_state.should == ["X", " ", " ", " ", " ", " ", " ", " ", " "]
#     end
# end