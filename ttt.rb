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

  action( firstmove )
  
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

def check_win
  # Checks the board for win conditions
end

def action turn
  if turn == :player
    player_action()
  elsif turn == :computer
    computer_action()
  else
    puts "Error, turn variable not set correctly."
  end
end

def firstmove
  prompt
  choice = gets.chomp
  
  if choice =~ /\A[pP]layer\z/
    choice = :player
  elsif choice =~ /\A[cC]omputer\z/
    choice = :computer
  else
    puts "Please enter a valid selection."
    firstmove
  end
end

def next( turn )
  if turn == :player
    turn = :computer
  elsif turn == :computer
    turn = :player
  else
    puts "ERROR: Turn must be computer or player."
    return nil
  end
end

# Usefuls bits and pieces

def prompt
  print "> "
end