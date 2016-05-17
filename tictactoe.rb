module UserInterface
  def greet_user
    puts "\nGreetings! Let's select some game options to get started."
  end

  def prompt_board_settings
    puts "\nWhat board size would you like for this game?"
    print "Enter '3' for a 3 x 3 board, '4' for a 4 x 4 board, '5' for a 5 x 5 board... : "
  end

  def prompt_player_settings
    print "\nExcellent. Now, would you like to play against the computer? (Y/N) "    
  end

  def prompt_token
    print "\nWhat token do you want to use, 'X' or 'O'? "
  end

  def prompt_again
    puts "\nUhh, that's not a valid answer. Try again."
  end

  def yes?
    gets.chomp.upcase == "Y"
  end
end

class Player
  attr_accessor :humanity, :token, :turn
  # a player's humanity, token, and turn attributes are publicly accessible outside of this class

  def initialize(humanity)
    @humanity = humanity # human or computer
  end

  def has_valid_token?
    ["X", "O"].include?(token)
  end

  def has_turn?
  end

  def plays_first?
  end

  def makes_valid_move?
  end

  def move()
  end

  def think()
  end
end

class Board
  attr_accessor :dimension
  # a board's dimension attribute is publicly accessible

  def initialize(dimension)
    @dimension = dimension
  end

  def has_invalid_size?
    dimension < 3
  end

  def display
    puts "\n", ascii_rows.join( "\n" + "-" * (dimension**2 + (dimension-1)) + "\n" )
  end

  def ascii_rows
    rows.map{ |row| prettify(row).join }
  end

  def prettify(row)
    row.map do |cell|
      cell == row.last ? "#{cell}".center(dimension) : "#{cell}".center(dimension) + "|"
    end
  end

  def rows
    array.each_slice(dimension).to_a
  end

  def array
    (1..dimension**2).to_a.map(&:to_s)
  end

  def victory?
    # enforce single responsibility everywhere
    # separate iteration from the action that's being performed on each element
  end

  def game_over?
  end
end

class Game
  include UserInterface

  attr_accessor :first_player, :second_player

  def initialize(args)
    @first_player = args[:first_player]
    @second_player = args[:second_player]
    greet_user
  end

  def set_board_size
    prompt_board_settings
    board
  end

  def validate_board
    if board.has_invalid_size?
      prompt_again
      set_board_size
    end
  end

  def set_player_options
    prompt_player_settings
    if yes?
      second_player.humanity = false
    end
  end

  def set_tokens
    prompt_token
    first_player.token = gets.chomp.upcase
  end

  def validate_tokens
    if first_player.has_valid_token?
      first_player.token == "X" ? second_player.token = "O" : second_player.token = "X"
    else
      prompt_again
      set_tokens
    end
  end

  # print "\nDo you want to play first? (Y/N) " ################################

  def board
    @board ||= Board.new(gets.chomp.to_i)
  end

  # def restart?
  #   print "Would you like to play again? (Y/N) "
  #   yes?
  # end

  # def restart
  #   restart? ? self.new : quit
  # end

  def quit
    exit(0)
  end
end


### test for boards of various dimensions
# (1..8).map { |i| Board.new(i).display }

### greet the player, initialize & display a new game board, etc.
g = Game.new({
  first_player: Player.new(true),
  second_player: Player.new(true)})

g.set_board_size
g.validate_board
g.board.display
g.set_player_options
g.set_tokens
g.validate_tokens
