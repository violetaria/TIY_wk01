require 'pry'

PLAYER1_MARKER="X"
PLAYER2_MARKER="O"
WINNING_BOARDS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
board = (1..9).to_a

def show_board(board)
  puts "\n====== Current board ======"
  puts "
       #{board[0]} | #{board[1]} | #{board[2]}
       ---------
       #{board[3]} | #{board[4]} | #{board[5]}
       ---------
       #{board[6]} | #{board[7]} | #{board[8]}
       "
  puts "===========================\n"
end

def greeting
  puts "Welcome to Tic-Tac-Toe!"
  puts
  puts "Rules:
        Game supports 1 or 2 players.
        Players alternate turns.
        Player1 = Xs
        Player2 = Os

        Each position on the board is numbered.
        During your turn, enter a number which corresponds to an open position.
        If a number is replaced by an X or an O, that spot has already been claimed.
        Ready, Set, Go!
        "
  print "\nHow many players? "
  gets.chomp.to_i
  ## TODO input validation
end

def get_player_name(player)
  print "Player #{player}, enter your name: "
  gets.chomp
end

def game_over?
  ## TODO

end

def get_pick(current_player)
  print "#{current_player}, it's your turn!  Choose wisely: "
  gets.chomp.to_i
  ## TODO - input validation
end

def update_board(pick,marker,board)
  board[pick-1] = marker
  board
end

def complete_game
  ## TODO
end

def play_again?
  ## TODO
end

def play_t3(board)
  num_players = greeting
  player1 = get_player_name(1)
  player2 = num_players==2 ? get_player_name(2) : "Unimatrix Zero"
  current_player = player1
  current_marker = PLAYER1_MARKER
  show_board(board)
  until game_over?
    pick = get_pick(current_player)
    board = update_board(pick,current_marker,board)
    show_board(board)
    if(current_player == player1)
      current_player = player2
      current_marker = PLAYER2_MARKER
    else
      current_player = player1
      current_marker = PLAYER1_MARKER
    end
    binding.pry
  end
  complete_game
  play_again?
end

play_t3(board)

#binding.pry

