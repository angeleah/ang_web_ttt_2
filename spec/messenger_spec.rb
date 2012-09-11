require "spec_helper"
require "ang_ttt_gem"
require "game_repository"
require "messenger"
require "game"
require "validate"

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
    
    it 'should collect player data ' do
      type_1 = "human"
      mark_1 = "x"
      type_2 = "computer"
      mark_2 = "o"
      data = messenger.collect_player_data(type_1, mark_1, type_2, mark_2)
      data.should == "O"
    end
    
    it 'should return true if a game is set up properly' do
      
    end
    
    it 'should return false if a game is not set up properly' do
      
    end
    
    it 'should return true when given valid mark data' do
      mark_1 = "p"
      mark_2 = "z"
      messenger.valid_mark_data?(mark_1, mark_2).should == true
    end
    
    it 'should return true when given valid mark data' do
      mark_1 = "1"
      mark_2 = "z"
      messenger.valid_mark_data?(mark_1, mark_2).should == false
    end
    
    it 'should be able to create one player' do
      type = "human"
      mark = "X"
      messenger.create_player(type, mark)
      game.players[0].should be_an_instance_of(HumanPlayer)
    end
    
    it 'should be able to create multiple players' do
      type_1 = "human"
      mark_1 = "X"
      type_2 = "computer"
      mark_2 = "O"
      game.players[0].should be_an_instance_of(HumanPlayer)
      game.players[1].should be_an_instance_of(ComputerPlayer)
      game.players.count.should == 2
    end
    
    
    
    it 'should turn the params from index into a hash for the .yml file' do
      @type_1 = "human"
      @mark_1 = "A"
      @type_2 = "computer"
      @mark_2 = "P"
      @player = 1
      @board_state = messenger.game.stub(:gather_board_state).and_return([" ", " ", " ", " ", " ", " ", " ", " ", " ",])
      data = messenger.prepare_hash_for_storage
      data.should == 
      {
        :type_1 => "human",
        :mark_1 => "A",
        :type_2 => "computer",
        :mark_2 => "P",
        :turn => 1,
        :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " ",]
      }
    end
    
    it 'should be able to set a turn' do
      
    end
    
    it 'should be able to switch turns' do
      
    end
    
    it 'should choose computer move when it should not display the board' do
      
    end
    
    it 'should save and prepare the game state when display_board?' do
      
    end
    
    it 'should be able to determine if it should display the board' do
      
    end
   
   it 'should be able to prepare and save the state' do
     
   end 
   
   it 'should e able to gather the board state' do
     
   end
   
   it 'may need to rethink the use of the get move' do
     
   end
   
   it 'should should be able to make a computer move' do
     
   end
   
   it 'should be able to check for win lose or draw' do
     
   end
   
   it  'should return true when given valid data' do
     
   end
   
   it  'should return false when given invalid data' do
     
   end
   
   it 'should be able to prepare a hash for storage' do
     
   end
   
    it 'should be able to save a game state' do
         save_game_state(game_data)
         File.read("./state_machine.yml").should include("human", "computer", "A", "P", " ", "1")
       end
   
       it 'should be able to load the game state' do
         save_game_state(game_data)
         @fetched_data = load_game_state
         @fetched_data.should == 
         {
           :type_1 => "human",
           :mark_1 => "A",
           :type_2 => "computer",
           :mark_2 => "P",
           :turn => 1,
           :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " "]
         }
       end
   
       it 'should be able to reconstruct a game' do
         reconstruct_game
         @type_1.should == @data[:type_1]
         @mark_1.should == @data[:mark_1]
         @type_2.should == @data[:type_2]
         @mark_2.should == @data[:mark_2]
         @player.should == @data[:turn]
         @board_state.should == @data[:board_state]
         @game.players.count.should == 2
       end
   
       it 'should be able to populate a board' do
         @game = Game.new
         board_state = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
         populate_board(board_state)
         @game.gather_board_state.should == ["X", " ", " ", " ", " ", " ", " ", " ", " "]
       end
   
end