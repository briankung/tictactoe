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

def player_action
  # Prompts player for action and marks spot on board
  puts "Hey hey playa"
end

def computer_action
  # Computer's move
  puts "Resistance is futile"
end

def check_win board
  # Checks the board for win conditions.
  #
  for index in 0..2
    player_wins if add_row( board, index ) =~ /x{3}/ || add_col( board, index ) =~ /x{3}/
    computer_wins if add_row( board, index ) =~ /o{3}/ || add_col( board, index ) =~ /o{3}/
  end
  
  player_wins if add_fwd_diag( board ) =~ /x{3}/ || add_back_diag( board ) =~ /x{3}/
  computer_wins if add_fwd_diag( board ) =~ /o{3}/ || add_back_diag( board ) =~ /o{3}/
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

def action( board, turn)
  unless check_win board  # Psuedo-code. Fix later.
    if turn == :player
      player_action
      turn = next_player turn
    elsif turn == :computer
      computer_action
      turn = next_player turn   #God, this is awkward.
    else
      puts "turn variable in action method has fucked up"
    end
  end
end

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