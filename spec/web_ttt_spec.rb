require 'spec_helper'
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
    post "/board", :cell=> "3"
    last_response.body.include?('Start Over').should == true
  end
end