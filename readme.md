KIN WAS HERE HAHAHAHA

Readme:

Tic Tac Toe is the classic game in command line. This version pits the player against a perfect computer player that wins whenever possible and cannot lose.

Directions:

1. fire up irb
2. load "ttt.rb"
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
        
**Bugs**

* [FIXED] Win check fails for rows 2 and 3
* [FIXED] Win check fails for columns B and C
* [FIXED] Computer cheats like a whore in certain situations.
* [FIXED] Also, you know...doesn't win. Legally.
* Computer chooses spots randomly when not in immediate danger
* Falls prey to traps
* User can overwrite old inputs and rewrite the board <.<

Oddly enough, random is almost good enough to pass as AI.

3/1/2012 11:54:45 AM
Added some bitching and moaning. Look for "pick up from here" or "pick up" to pick up on code.