require "spec_helper"
require "ang_ttt_gem"
require "game_repository"
require "messenger"
require "game"
require "validate"
require "securerandom"
require "fileutils"

describe 'Messenger' do

  let(:messenger) { Messenger.new }
  
  after(:all) do
    FileUtils.rm_rf("games")
    FileUtils.mkdir("games")
  end

  it 'should collect player data' do
    type_1 = "human"
    mark_1 = "X"
    type_2 = "computer"
    mark_2 = "O"
    data = messenger.collect_player_data(type_1, mark_1, type_2, mark_2)
    data.should == "O"
  end

  it 'should return true if a game is set up properly' do
    messenger.set_up_game("human", "X", "computer", "O").should == true
  end

  it 'should return false if a game is not set up properly' do
    messenger.set_up_game("human", "1", "computer", "O").should == false
  end

  it 'should return true when given valid mark data' do
    mark_1 = "p"
    mark_2 = "z"
    messenger.valid_mark_data?(mark_1, mark_2).should == true
  end

  it 'should return false when given invalid mark data' do
    mark_1 = "1"
    mark_2 = "z"
    messenger.valid_mark_data?(mark_1, mark_2).should == false
  end

  it 'should be able to create one player' do
    type = "human"
    mark = "X"
    messenger.create_player(type, mark)
    messenger.game.players[0].should be_an_instance_of(HumanPlayer)
  end

  it 'should be able to create multiple players' do
    type_1 = "human"
    mark_1 = "X"
    type_2 = "computer"
    mark_2 = "O"
    messenger.create_players(type_1, mark_1, type_2, mark_2)
    messenger.game.players[0].should be_an_instance_of(HumanPlayer)
    messenger.game.players[1].should be_an_instance_of(ComputerPlayer)
    messenger.game.players.count.should == 2
  end

  it 'should be able to prepare a hash for storage' do
    @player = 1
    messenger.collect_player_data("human", "A", "computer", "P")
    messenger.set_turn
    data = messenger.prepare_hash_for_storage
    data.should == {
      :type_1 => "human",
      :mark_1 => "A",
      :type_2 => "computer",
      :mark_2 => "P",
      :turn => 1,
      :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    }
  end

  it 'should be able to set a turn' do
    messenger.set_turn.should == 1
  end

  it 'should be able to switch turns' do
    messenger.set_turn
    messenger.switch_turn.should == 2
  end
  
  it 'should choose computer_move when display_board? is false' do
    cell = nil
    messenger.set_up_game("computer", "X","human", "O")
    board_state = ["X", "O", "X", "O", "O", " ", "O", "X", "X"]
    messenger.populate_board(board_state)
    messenger.game.stub(:get_player_move).and_return(5)
    messenger.ai_move_if_possible.should == [["X", "O", "X", "O", "O", "X", "O", "X", "X"], "Player 1 is the winner!\n"]
  end

  it 'should save and prepare the game state when display_board? is true' do
    cell = nil
    messenger.set_up_game("human", "X","computer", "O")
    board_state = ["X", "O", "X", "O", "O", " ", "O", "X", "X"]
    messenger.populate_board(board_state)
    messenger.game.stub(:get_player_move).and_return(false)
    messenger.ai_move_if_possible.should == [["X", "O", "X", "O", "O", " ", "O", "X", "X"], nil]
  end

  it 'should not display the board if get_move is true' do
    messenger.set_up_game("computer", "X","human", "O")
    messenger.display_board?.should == false
  end

  it 'should display the board if get_move is false' do
    messenger.set_up_game("human", "X","computer", "O")
    messenger.display_board?.should == true
  end

  it 'should be able to prepare and save the state' do
    messenger.set_up_game("human", "A","computer", "P")
    board_state = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
    messenger.populate_board(board_state)
    messenger.prepare_hash_for_storage
    messenger.prepare_and_save_state.should == ["X", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  it 'should be able to gather the board state' do
    board_state = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
    messenger.populate_board(board_state)
    messenger.game.gather_board_state.should == board_state
  end

  it 'should be able to make a computer move' do
    messenger.set_up_game("computer", "X","human", "O")
    board_state = ["X", "O", "X", "O", "O", " ", "O", "X", "X"]
    messenger.populate_board(board_state)
    messenger.game.stub(:get_player_move).and_return(5)
    messenger.computer_move.should == [["X", "O", "X", "O", "O", "X", "O", "X", "X"], "Player 1 is the winner!\n"]
  end
  
  it 'should should be able to prepare a message' do
    messenger.game.stub(:is_over?).and_return(true)
    messenger.game.stub(:result).and_return(:draw)
    messenger.prepare_message.should == "It's a draw.\n"
  end

  it 'should detect if a move is valid' do
   data = messenger.stub(:reconstruct_game).and_return({
      :id => 45,
      :type_1 => "human",
      :mark_1 => "A",
      :type_2 => "computer",
      :mark_2 => "P",
      :turn => 1,
      :board_state => ["X", "O", "X", "O", "O", " ", "O", "X", "X"]
    })
    messenger.populate_board(["X", "O", "X", "O", "O", " ", "O", "X", "X"])
    messenger.valid_move?(5).should == true
  end
  
  it  'should detect if a move is invalid' do
    data = messenger.stub(:reconstruct_game).and_return({
        :id => 45,
        :type_1 => "human",
        :mark_1 => "A",
        :type_2 => "computer",
        :mark_2 => "P",
        :turn => 1,
        :board_state => ["X", "O", "X", "O", "O", " ", "O", "X", "X"]
      })
      messenger.populate_board(["X", "O", "X", "O", "O", " ", "O", "X", "X"])
      messenger.valid_move?(0).should == false
  end

  it 'should be able to save a game state' do
    game_data = {
      :type_1 => "human",
      :mark_1 => "A",
      :type_2 => "computer",
      :mark_2 => "P",
      :turn => 1,
      :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    }
    game_id = messenger.game_id
    messenger.save_game_state(game_data)
    File.read("games/#{game_id}.yml").should include("human", "computer", "A", "P", " ", "1")
  end

  it 'should be able to load the game state' do
    game_data = 
      {
        :type_1 => "human",
        :mark_1 => "A",
        :type_2 => "computer",
        :mark_2 => "P",
        :turn => 1,
        :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      }
    messenger.save_game_state(game_data)
    fetched_data = messenger.load_game_state
    fetched_data.should == 
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
    messenger.stub(:load_game_state).and_return({
      :type_1 => "human",
      :mark_1 => "A",
      :type_2 => "computer",
      :mark_2 => "P",
      :turn => 1,
      :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    })
    messenger.reconstruct_game.should == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    messenger.game.players.count.should == 2
  end

  it 'should be able to populate a board' do
    messenger.set_up_game("human", "X", "computer", "O")
    board_state = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
    messenger.populate_board(board_state).should == ["X", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  
  it 'should should be able to delete a game file' do
     game_data = {
        :type_1 => "human",
        :mark_1 => "A",
        :type_2 => "computer",
        :mark_2 => "P",
        :turn => 1,
        :board_state => [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      }
      game_id = messenger.game_id
      messenger.save_game_state(game_data)
      File.exists?("games/#{game_id}.yml").should == true
      messenger.delete_game_file
      File.exists?("games/#{game_id}.yml").should == false
  end
end