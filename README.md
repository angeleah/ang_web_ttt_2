Sinatra Tic Tac Toe
===================
This app is another version of my tic tac toe. You can play human vs. human or computer vs. computer or human vs. computer. The computer will always win if you play against it.  It uses my original tic tac toe that I packaged into a gem as the core logic. It uses the minimax algorithm to make move decisions. It uses a .yml file to save the state of the game while playing. This was done to get a feel for how to build this using a bit different technology.

Usage:
------
- To run the app:
  + Clone the repo.
  + cd to the directory.
  + Bundle.
  + Start the server $ ruby web_ttt.rb
  + Open a browser window and navigate to localhost:4567
  + Play some Tic Tac Toe.
- To run the specs:
 + cd to the directory.
 + Type $ rspec
