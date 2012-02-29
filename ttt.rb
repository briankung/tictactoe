# Display a board
  # Ask who should go first
    # Set player indicator
  # Players alternate moves until win conditions met
    # Human: Ask for input in form a1, b2, c3, etc.
      # Parse move input
        # Must be two characters, /([abc][123])/i
          # Else, throw a hissy fit
    # Computer
      # AI chooses a move somehow. Dammit      
    # After every player move, check win
      # If win, congratulate or console player

def tictactoe
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
      turn = next_player turn   #God, this is awkward.
    else
      puts "turn variable in action method has fucked up"
    end
  end
  
  display board
  puts "#{check_win(board).last} won!"
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
    player_action( board )
  else
    board[to_index(selection)] = "x"
  end   
end

def computer_action( board )
  # Computer's move
  # Insert some sort of AI wizardry
  display( board )
  puts
  puts "Resistance is futile"
  prompt
  gets
end

def check_win board
  three_o = /o{3}/
  three_x = /x{3}/
  
  for index in 0..2
    if add_row( board, index ) =~ three_x
      return [true, "The player"]
    elsif add_row( board, index ) =~ three_o
      return [true, "The computer"]
    elsif add_col( board, index ) =~ three_x
      return [true, "The player"]
    elsif add_col( board, index ) =~ three_o
      return [true, "The computer"]
    end
  end

  if add_fwd_diag( board ) =~ three_x
    return [true, :player]
  elsif add_fwd_diag( board ) =~ three_o
    return [true, :computer]
  elsif add_back_diag( board ) =~ three_x
    return [true, :player]
  elsif add_back_diag( board ) =~ three_o
    return [true, :computer]
  else
    return [false, false]
  end
end

# String concatenations for checking win conditions

def add_row( array, index )
  array[index * 3].to_s + array[index * 3 + 1].to_s + array[index * 3 + 2].to_s
end

def add_col( array, index )
  array[index].to_s + array[index + 3].to_s + array[index + 6].to_s
end

def add_fwd_diag( array )
  array[0].to_s + array[4].to_s + array[8].to_s
end

def add_back_diag( array )
  array[2].to_s + array[4].to_s + array[6].to_s
end

# Yep.

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