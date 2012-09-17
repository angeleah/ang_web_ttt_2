require 'spec_helper'
require 'rack/test'
require 'web_ttt'
require "ang_ttt_gem"
require "game_repository"
require "messenger"

set :environment, :test

def app
  Sinatra::Application
end

describe 'ang_web_ttt_2' do
  include Rack::Test::Methods
  
  after(:all) do
    FileUtils.rm_rf("games")
    FileUtils.mkdir("games")
  end

  it 'should should load the homepage' do
    get '/'
    last_response.should be_ok
  end

  it 'should load /start_over' do
    get '/start_over'
    last_response.should be_ok
  end

  it 'should load the quit page' do
    get '/quit'
    last_response.should be_ok 
  end

  it 'should render the index page if set_up_turn is false' do
    post "/", :player_1_type=> "human", :player_1_mark => "x", :player_2_type => "computer", :player_2_mark => "7"
    last_response.body.include?('Welcome to Tic-Tac-Toe').should == true
  end

  it 'should render the board if set_up_game is true' do
    post "/", :player_1_type=> "human", :player_1_mark => "x", :player_2_type => "computer", :player_2_mark => "w"
    last_response.body.include?('Quit Game').should == true
  end

  it 'should render the board after each action' do
    data = {
    :type_1 => "super_computer",
    :mark_1 => "X",
    :type_2 => "human",
    :mark_2 => "O",
    :board_state => ["X", "X", "O", "X", "O", " ", " ", "X", "O"] 
    }
    File.open("games/4.yml", "w") do |f|
      f.print data.to_yaml
    end
    @messenger = Messenger.new(4)
    @messenger.stub(:load_game_state).and_return(data)
    @messenger.reconstruct_game
    post "/board", :cell=> "3", :game_id => 4
    last_response.body.include?('Start Over').should == true
  end
end