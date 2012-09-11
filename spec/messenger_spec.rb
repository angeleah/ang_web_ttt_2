require "spec_helper"
require "ang_ttt_gem"
require "game_repository"
require "messenger"

describe 'Messenger' do

  let(:game)      { Game.new }
  let(:messenger) { Messenger.new }
  # let(:game_data) { data = 
  #                   {
  #                     :type_1 => "human",
  #                     :mark_1 => "A",
  #                     :type_2 => "computer",
  #                     :mark_2 => "P",
  #                     :turn => 1,
  #                     :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " ",]
  #                   }
  #                 }

    # it 'should turn the params from index into a hash for the .yml file' do
    #   @type_1 = "human"
    #   @mark_1 = "A"
    #   @type_2 = "computer"
    #   @mark_2 = "P"
    #   @player = 1
    #   binding.pry
    #   @board_state = messenger.game.stub(:gather_board_state).and_return([" ", " ", " ", " ", " ", " ", " ", " ", " ",])
    #   data = messenger.prepare_hash_for_storage
    #   data.should == 
    #   {
    #     :type_1 => "human",
    #     :mark_1 => "A",
    #     :type_2 => "computer",
    #     :mark_2 => "P",
    #     :turn => 1,
    #     :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " ",]
    #   }
    # end
    
    it 'should collect player data ' do
      type_1 = "human"
      mark_1 = "x"
      type_2 = "computer"
      mark_2 = "o"
      data = messenger.collect_player_data(type_1, mark_1, type_2, mark_2)
      data.should == "O"
    end
    
    # it 'should be able to create one player' do
    #   type = "human"
    #   mark = "X"
    #   messenger.create_player(type, mark)
    #   game.players[0].should be_an_instance_of(HumanPlayer)
    # end
    # 
    # it 'should be able to create multiple players' do
    #   type_1 = "human"
    #   mark_1 = "X"
    #   type_2 = "computer"
    #   mark_2 = "O"
    #   game.players[0].should be_an_instance_of(HumanPlayer)
    #   game.players[1].should be_an_instance_of(ComputerPlayer)
    #   game.players.count.should == 2
    # end
end