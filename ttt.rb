# Tic Tac Toe implemented in Ruby command line.
# The game itself is the tic_tac_toe function. Fire it up and
# everything should be self explanatory.

def tic_tac_toe
  board = []
  9.times do
    board << "_"
  end
  
  display board
  puts
  puts "Who should go first? Type \"player\" or \"computer\""
  puts "without the quotation marks to make your choice."
  
  action( board, first_move )
  
end

def display( board )
  system 'cls'
  linewidth = 50
  
  puts('   a b c'.center(linewidth))
  puts
  
  for row in 1..3
    offset = (row - 1) * 3
    puts("#{row}: #{board[offset]}|#{board[offset + 1]}|#{board[offset + 2]}".center(linewidth))
  end
end

def action( board, turn)
  until check_win( board ).first
    if turn == :player
      player_action board
      turn = next_player turn
    elsif turn == :computer
      computer_action board
      turn = next_player turn
    else
      puts "turn variable in action method has fucked up"
    end
  end
  
  display board
  puts "#{check_win(board).last} won!"
  puts "Play again? (yes/no)"
  replay = gets.chomp
  if replay =~ /\A[y|yes]\z/i
    tic_tac_toe
  elsif replay =~ /\A[n|no]\z/i
    puts "Bye!"
  else
    puts "I didn't understand that. Here's a picture of a cat!"
    puts
    puts "               )\\._.,--....,'``.         "
    puts " .b--.        /;   _.. \\   _\\  (`._ ,.  "
    puts "`=,-,-'~~~   `----(,_..'--(,_..'`-.;.'    "
    puts
  end

end

def player_action( board )
  # Prompts player for action and marks spot on board
  display( board )
  puts
  puts "Hey hey playa. What's your move?"
  puts "Please use the form a1, b2, c3, etc."
  prompt
  selection = gets.chomp.scan(/\A[abc][123]/).first

  if selection.nil?
    puts "I didn't understand that. Press enter to try again."
    gets
    player_action(board)
  elsif board[to_index(selection)] == "_"
    board[to_index(selection)] = "x"
  else
    puts "You can't rewrite the board!"
    gets
    player_action(board)
  end   
end

def computer_action( board )
  # Computer's move
  # Insert some sort of AI wizardry
  hal( board )
  display( board )
  puts
  puts "Computer: Resistance is futile"
  gets
end

def check_win board
  ooo = "ooo"
  xxx = "xxx"
  
  for index in 0..2
    rows = add_row( board, index )
    cols = add_col( board, index )

    if rows == xxx
      return [true, "The player"]
    elsif rows == ooo
      return [true, "The computer"]
    elsif cols == xxx
      return [true, "The player"]
    elsif cols == ooo
      return [true, "The computer"]
    end
  end
  
  fwd_diag = add_fwd_diag( board )
  back_diag = add_back_diag( board )

  if fwd_diag == xxx
    return [true, :player]
  elsif fwd_diag == ooo
    return [true, :computer]
  elsif back_diag == xxx
    return [true, :player]
  elsif back_diag == ooo
    return [true, :computer]
  elsif board.index("_").nil?
    return [true, "Nobody"]
  else
    return [false, false]
  end
end

# check_win helpers. Also seen in near_win?().

def add_row( array, index )
  offset = index * 3
  array[offset] + array[offset + 1] + array[offset + 2]
end

def add_col( array, index )
  array[index] + array[index + 3] + array[index + 6]
end

def add_fwd_diag( array )
  array[0] + array[4] + array[8]
end

def add_back_diag( array )
  array[2] + array[4] + array[6]
end

# Computer player logic. We'll call her...HAL.

def hal( board )

  if near_win(board, :computer)
    attack(board)
  elsif near_win(board, :player)
    defend(board)
  elsif check_trap(board) == [true, :computer]
    set_trap(board)
  elsif check_trap(board) == [true, :player]
    block_trap(board)
  else
    empty_spots = find_all_moves(board, :blank)
    board[empty_spots.shuffle.last] = "o"
  end
end

# These are kind of extraneous.

def defend( board )
  plug_hole( board, :player)
end

def attack( board )
  plug_hole( board, :computer )
end

def check_trap( board )
  # Returns true or false and who is trapping whom
  # Ex. return [true, :computer] #=> Computer's advantage
  all_moves       = find_all_moves(board, :all)
  computer_moves  = find_all_moves(board, :computer)
  player_moves    = find_all_moves(board, :player)
  
  # if all_moves.length == 1 && player_moves.length == 1
    # return[true, :player]
  # elsif player_moves.length == 2 && computer_moves.length == 1
    # return[true, :player]
  # elsif all_moves.length == 0
    # return[true, :computer]
  # elsif player_moves.length == 1 && computer_moves.length == 1
    # return[true, :computer]
  # elsif player_moves.length == 1 && computer_moves.length == 1
    
  # end
  
  return false
end

def block_trap( board )
end

def set_trap( board )
end

# Corners - top left, top right, bottom left, bottom right.
# Sides - top, left, right, bottom

def categorize( array )
  hash = {
  :corners => [ array[0], array[2], array[6], array[8] ],
  :sides => [ array[1], array[3], array[5], array[7] ],
  :center => array[4]
  }
end
  

def plug_hole( board, agent)
  almost = near_win(board, agent)

  if almost
    board[ almost ] = "o"
  end  
end

def find_all_moves( board, agent )
  locations = []
  copy = board.clone
  
  if agent == :computer
    token = "o"
  elsif agent == :player
    token = "x"
  elsif agent == :blank
    token = "_"
  elsif agent == :all
    return find_all_moves(board, :computer) + find_all_moves(board, :player)
  else
    puts "Input for find_all_moves is incorrect"
  end

  until copy.index(token).nil?
    locations << copy.index(token)
    copy[copy.index(token)] = " "
  end

  return locations
end

def near_win( board, agent )

  if agent == :player
    test = /x{2}|x_x/
  elsif agent == :computer
    test = /o{2}|o_o/
  end
  
  danger_zone = 0 # Returned and used as array index

  # The unless loops prevent failure when rows/cols/diags
  # are full. Ex. "xoo"

  for index in 0..2
    rows = add_row( board, index )
    cols = add_col( board, index )
    x_coord = rows.index("_")
    y_coord = cols.index("_")

    if rows =~ test
      unless x_coord.nil?
        danger_zone = index * 3 + x_coord
        return danger_zone
      end
    elsif cols =~ test
      unless y_coord.nil?
        danger_zone = index + y_coord * 3
        return danger_zone
      end
    end
  end
  
  fwd_diag = add_fwd_diag( board )
  back_diag = add_back_diag( board )

  if fwd_diag =~ test
    unless fwd_diag.index("_").nil?
      danger_zone = fwd_diag.index("_") * 4
      return danger_zone
    end
  elsif back_diag =~ test
    unless back_diag.index("_").nil?
      danger_zone = (back_diag.index("_") + 1) * 2
      return danger_zone
    end
  else
    return false
  end
end

# Bits and pieces.

def first_move
  prompt
  choice = gets.chomp
  
  if choice =~ /\A[pP]layer\z/
    choice = :player
  elsif choice =~ /\A[cC]omputer\z/
    choice = :computer
  else
    puts "Please enter a valid selection."
    first_move
  end
end

def next_player( turn )
  if turn == :player
    turn = :computer
  elsif turn == :computer
    turn = :player
  else
    puts "ERROR: Turn must be computer or player."
    return nil
  end
end

def to_index ( selection )
  index = 0
  case selection[0]
  when "a"
    index += 0
  when "b"
    index += 1
  when "c"
    index += 2
  else
    puts 'selection[0] is malformed'
  end
  
  case selection[1]
  when "1"
    index += 0
  when "2"
    index += 3
  when "3"
    index += 6
  else
    puts 'selection[1] is malformed'
  end
  
  return index
end

def prompt
  print "> "
end