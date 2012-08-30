require 'spec_helper'
require 'web_ttt.rb'

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
end