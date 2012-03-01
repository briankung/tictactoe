Readme:

Tic Tac Toe is the classic game in command line. This version pits the player against a perfect computer player that wins whenever possible and cannot lose.

Directions:

1. fire up irb
2. require ttt.rb
3. use command "tic_tac_toe" (without parentheses) to play.

**Roadmap**

    Playable game
        Display board
        Player's turn
            Graphical select
        Computer's turn
            1. Never lose (block)
                2 in a row? Block it.
            2. Win (attack)
                Place first
                Prefer placing with clear line of sight to own marks
                Traps
                    Middle
        Win conditions

**Old notes to self in ttt.rb**

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
        
**Bugs**

* [FIXED] Win check fails for rows 2 and 3
* [FIXED] Win check fails for columns B and C
* [FIXED] Computer cheats like a whore in certain situations.
* [FIXED] Also, you know...doesn't win. Legally.
* Computer chooses spots randomly when not in immediate danger
* Falls prey to traps
* User can overwrite old inputs and rewrite the board <.<

Oddly enough, random is almost good enough to pass as AI.