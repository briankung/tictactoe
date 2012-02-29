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
  
  for row in 0..2
    offset = row * 3
    puts("#{row}: #{board[offset]}|#{board[offset + 1]}|#{board[offset + 2]}".center(linewidth))
  end
end

def action( board, turn)
  while check_win( board ) == false    # This doesn't work because you are dumb
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
end

def player_action( board )
  # Prompts player for action and marks spot on board
  display( board )
  puts "Hey hey playa"
  gets
end

def computer_action( board )
  # Computer's move
  display( board )
  puts "Resistance is futile"
  gets
end

def check_win board
  # Checks the board for win conditions.
  for index in 0..2
    if add_row( board, index ) =~ /x{3}|o{3}/
      return true
    elsif add_col( board, index ) =~ /x{3}|o{3}/
      return true
    elsif add_fwd_diag( board ) =~ /x{3}|o{3}/
      return true
    elsif add_back_diag( board ) =~ /x{3}|o{3}/
      return true
    else
      return false
    end      
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

def prompt
  print "> "
end