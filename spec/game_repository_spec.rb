require "spec_helper"
require "game_repository"
require "ang_ttt_gem"
require "game"
require "yaml"

describe 'GameRepository' do
  
  let (:gr) { GameRepository.new }
  
  it 'should be able to save the game data to a file' do
    data = {
    :id => 45,
    :type_1 => "computer",
    :mark_1 => "X",
    :type_2 => "human",
    :mark_2 => "O",
    :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] 
    }
    gr.save(data)
    File.read("./state_machine.yml").should include("human", "computer", "X", "O", " ")
  end
  
  it 'should assign an id to a hash'
    # data = {
    # :type_1 => "computer",
    # :mark_1 => "X",
    # :type_2 => "human",
    # :mark_2 => "O",
    # :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] }
    # id = gr.add_id_to(data)
    #     # id.should ==
  
  it 'should start counting at 1 for the first entered game' do
    data = {
    :id => nil, 
    :type_1 => "computer",
    :mark_1 => "X",
    :type_2 => "human",
    :mark_2 => "O",
    :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] 
    }
    data_with_id = gr.add_id_to(data)
    data_with_id[:id].should satisfy {|s| [1..100].include?(s)}
  end
  
  # it 'should not create an id if one already exists'
  #   data = {
  #   :id => nil, 
  #   :type_1 => "computer",
  #   :mark_1 => "X",
  #   :type_2 => "human",
  #   :mark_2 => "O",
  #   :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] 
  #   }
  #   gr.save_data(data)
  #   new_data = gr.read_all_game_data
  #   gr.create_id
  #   
  # end
  
  it 'should be able to read the game data from a file' 
    # @fetched_data = gr.load(3)
    # @fetched_data.should =={
    # :id => "3",
    # :type_1 => "computer",
    # :mark_1 => "X",
    # :type_2 => "human",
    # :mark_2 => "O",
    # :board => ["X", " ", "O", "X", "O", " ", " ", "X", "O"] }

end