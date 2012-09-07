require "spec_helper"
require "game_repository"
require "ang_ttt_gem"
require "game"
require "yaml"

describe 'GameRepository' do
  
  let (:gr) { GameRepository.new }
  
  it 'should be able to save the game data to a file' do
    @data = {
    :type_1 => "computer",
    :mark_1 => "X",
    :type_2 => "human",
    :mark_2 => "O",
    :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] }
    gr.save(@data)
    File.read("./state_machine.rb").should include("human", "computer", "X", "O", " ")
  end
  
  it 'should be able to read the game data from a file' do
    @fetched_data = gr.load
    @fetched_data.should == {
    :type_1 => "computer",
    :mark_1 => "X",
    :type_2 => "human",
    :mark_2 => "O",
    :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] }
  end
end
