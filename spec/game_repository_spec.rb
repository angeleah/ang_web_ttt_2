require "spec_helper"
require "game_repository"
require "ang_ttt_gem"
require "game"
require "yaml"

describe 'GameRepository' do
  
  let (:gr) { GameRepository.new }
  # let(:game) { Game.new }
  # type_1 = "computer"
  # mark_1 = "X"
  # type_2 = "human"
  # mark_2 = "O"
  
  # it 'should create a game with 2 players when passed a game' do
  #   game.create_computer_player("X")
  #   game.create_human_player("O")
  #   .count.should == 2
  # end
  
  it 'should be able to save the player type, mark to a file' do
    @data = {
    :type_1 => "computer",
    :mark_1 => "X",
    :type_2 => "human",
    :mark_2 => "O" }
    gr.save(@data)
    File.read("./state_machine.rb").should include("human", "computer", "X", "O")
  end
  
  it 'should be able to save the state of the board to a file' do
    @board_state = { 
      :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"]
      }
    gr.save(@board_state)
    File.read("./state_machine.rb").should include(" ")
  end
end
