require "sinatra"
#require "ang_ttt_gem"
#require "validate"
#require "game"

# before do
#   @game = if File.exists?('state_machine.rb')
#     File.open('state_machine.rb') do |file|
#       Marshal.load(file)
#     end
#   else
#     @game = Game.new
#   end
# end
#after do
def marsh(game)
  File.open('state_machine.rb', 'w') do |file|
    file.print Marshal.dump(@game)
  end
end

def read
  File.open('state_machine.rb','r') do |file|
    @game = Marshal.load(file)
  end
  @game
end

get '/' do
  @game = Game.new
  puts game
  marsh(@game)
  erb :index
end

get '/marsh_page' do
  read
  puts @game
  @result = @game
  erb :marsh_page
end

class Game
  attr_reader :players
  
  def initialize
    @players = ["HumanPlayer"]
    @board = Board.new
  end
  
  def make_move(move, mark)
    @board.set(move, mark)
  end
  
  def get_board
    @board.current_state
  end
end

class Board
  def initialize
     @cells = Array.new(9) {" "}
   end

   def get(cell_number)
     @cells[cell_number]
   end

   def set(cell_number, mark) 
     @cells[cell_number] = mark
   end
   
   def current_state
      current_state = @cells.map {|c| c}
   end
end


# post '/' do
#   @validate = Validate.new
#   type_1 = params[:player_1_type]
#   mark_1 = params[:player_1_mark].upcase
#   type_2 = params[:player_2_type]
#   mark_2 = params[:player_2_mark].upcase
#   if !@validate.mark_input(mark_1)
#     erb :index
#   elsif !@validate.mark_input(mark_2)
#     erb :index
#   else
#     create_player(type_1, mark_1)
#     create_player(type_2, mark_2)
#     @player = 1
#     player_1_move = get_move(@player)
#     if player_1_move == false
#       @state = @game.prepare_display_state
#       erb :board
#     else
#       @state = @game.make_move_player(@player, player_1_move)
#       switch_turn
#       erb :board
#     end
#   end
# end
# 
# def switch_turn
#    @player == 1 ? @player = 2 : @player = 1
# end
# 
# post '/board' do
#   cell_number = params[:cell]
#   player = params[:player].to_i
#   erb :board if @game.square_taken?(cell_number)
#   @state = @game.make_move_player(player, cell_number)
#   player = switch_turn
#   move = get_move(player)
#   if move == false
#     erb :board
#   else
#     @state = @game.make_move_player(player, move)
#     switch_turn
#     erb :board
#   end
# end
#   
#   def create_player(type, mark)
#     @game.create_human_player(mark) if type == "human"
#     @game.create_computer_player(mark) if type == "computer"
#   end