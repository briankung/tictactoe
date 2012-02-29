Readme:

Tic Tac Toe is the classic game in command line. This version pits the player against a perfect computer player that wins whenever possible and cannot lose.

Directions:

- fire up irb
- require ttt.rb
- use command "tictactoe" (without parentheses) to play.

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

Discovered some bugs:

* [FIXED] Win check fails for rows 2 and 3
* [FIXED] Win check fails for columns B and C
* Computer cheats like a whore in certain situations.