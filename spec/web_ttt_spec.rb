require 'spec_helper'
require 'web_ttt.rb'
require "ang_ttt_gem"

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
  
  it 'should render the homepage if the params are invalid' do
    post "/", :player_1_type=> "human", :player_1_mark => "x", :player_2_type => "computer", :player_2_mark => "7"
    last_response.body.include?('Welcome to Tic-Tac-Toe')
  end
  
  it 'should render the board if the params are valid' do
    post "/", :player_1_type=> "human", :player_1_mark => "x", :player_2_type => "computer", :player_2_mark => "w"
    last_response.body.include?("<td></td>")
  end

end

#@state.should == [...]
