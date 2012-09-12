require "pry"
require "ang_ttt_gem"
require "game"
require "validate"
require "game_repository"
require "message"

class Messenger
  
  attr_reader :game
  
  def initialize
    @game = Game.new
  end

  def collect_player_data(type_1, mark_1, type_2, mark_2)
    @type_1 = type_1
    @mark_1 = mark_1.upcase
    @type_2 = type_2
    @mark_2 = mark_2.upcase
  end

  def set_up_game(type_1, mark_1, type_2, mark_2)
    return false if !valid_mark_data?(mark_1, mark_2)
    collect_player_data(type_1, mark_1, type_2, mark_2)
    create_players(type_1, mark_1, type_2, mark_2)
    set_turn
    true
  end

  def valid_mark_data?(mark_1, mark_2)
    @validate = Validate.new
    @validate.mark_input(mark_1) && @validate.mark_input(mark_2)
  end

  def create_players(type_1, mark_1, type_2, mark_2)
    create_player(type_1, mark_1)
    create_player(type_2, mark_2)
  end

  def create_player(type, mark)
    @game.create_human_player(mark) if type == "human"
    @game.create_computer_player(mark) if type == "computer"
  end

  def set_turn
    @player = 1
  end
  
  def switch_turn
     @player == 1 ? @player = 2 : @player = 1
  end

  def decide_on_action
    if display_board?
      prepare_and_save_state
    else
      computer_move
    end
  end

  def display_board?
     get_move(@player) == false ? true : false
  end

  def prepare_and_save_state
    data = prepare_hash_for_storage
    save_game_state(data)
    gather_board_state
  end

  def gather_board_state
    @game.gather_board_state
  end

  def get_move(player)
    @game.get_player_move(player)
  end

  def computer_move
    while !display_board?
      player_move = get_move(@player)
      @game.make_move_player(@player, player_move)
      switch_turn
      prepare_and_save_state
      break if @game.is_over?
    end
    gather_board_state
  end

  def check_for_win_lose_draw
    message = Message.new
    @message = @game.result if @game.is_over?
  end

  def valid_move?(cell_number)
    if @game.square_taken?(cell_number)
      prepare_and_save_state
      false
    else
      true
    end
  end

  def prepare_hash_for_storage
    {
      :type_1 => @type_1,
      :mark_1 => @mark_1,
      :type_2 => @type_2,
      :mark_2 => @mark_2,
      :turn => @player,
      :board_state => @game.gather_board_state
    }
  end

  def save_game_state(data)
    @game_repository = GameRepository.new
    @game_repository.save(data)
  end

  def load_game_state
    @game_repository = GameRepository.new
    @game_repository.load
  end
  
  def populate_board(board_state)
    board_state.each_with_index{ |i, index|
      @game.make_move(index,i)
    }
  end

  def reconstruct_game
    data = load_game_state
    @type_1 = data[:type_1]
    @mark_1 = data[:mark_1]
    @type_2 = data[:type_2]
    @mark_2 = data[:mark_2]
    @player = data[:turn]
    @board_state = data[:board_state]
    @game = Game.new
    create_player(@type_1, @mark_1)
    create_player(@type_2, @mark_2)
    populate_board(@board_state)
  end
end