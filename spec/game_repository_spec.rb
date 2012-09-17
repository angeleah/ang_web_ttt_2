require "spec_helper"
require "game_repository"
require "ang_ttt_gem"
require "game"
require "yaml"

describe 'GameRepository' do

  let (:gr) { GameRepository.new }

  it 'should create a new file to save game data if one does not already exist' do
     data = { 
     :type_1 => "computer",
     :mark_1 => "X",
     :type_2 => "human",
     :mark_2 => "O",
     :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] 
     }
     data_with_id = gr.save(45, data)
     File.exists?("games/45.yml").should == true
   end

  it 'should be able to update the game data a file already exists' do
    data = {
    :type_1 => "super_computer",
    :mark_1 => "X",
    :type_2 => "human",
    :mark_2 => "O",
    :board => ["X", "X", "O", "X", "O", " ", " ", "X", "O"] 
    }
    gr.save(45, data)
    File.read("games/45.yml").should include("super_computer")
  end

  it 'should be able to read the game data from a file'  do
    data = gr.load(45)
    data.should =={
    :type_1 => "super_computer",
    :mark_1 => "X",
    :type_2 => "human",
    :mark_2 => "O",
    :board => ["X", "X", "O", "X", "O", " ", " ", "X", "O"] }
  end
  
  it 'should be able to delete a game file' do
    data = { 
     :type_1 => "computer",
     :mark_1 => "X",
     :type_2 => "human",
     :mark_2 => "O",
     :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] 
     }
     data_with_id = gr.save(45, data)
     File.exists?("games/45.yml").should == true
     gr.delete(45)
     File.exists?("games/45.yml").should == false
  end
end