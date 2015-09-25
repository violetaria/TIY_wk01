require 'pry'

PLAYER1_MARKER="X"
PLAYER2_MARKER="O"
WINNING_BOARDS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
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

def game_over?(player1_picks,player2_picks)
  # only check if > 3 picks or < 9
  if((player1_picks.length + player2_picks.length) > 2)
    win?(player1_picks) || win?(player2_picks) || (player1_picks.length + player2_picks.length) == 9
  end
end

def get_pick(player,board)
  print "#{player}, it's your turn!  Choose wisely: "
  pick = gets.chomp.to_i
  #binding.pry
  until board.include?(pick) && (1..9).include?(pick)
    puts "Hey! You already picked that or it isn't between 1 and 9!"
    print "Choose again: "
    pick = gets.chomp.to_i
  end
  pick
end

def update_board(pick,marker,board)
  board[pick-1] = marker
  board
end

def win?(picks)
  pick_combos = picks.sort.combination(3).to_a
  !(WINNING_BOARDS & pick_combos).empty?
end

def game_results(winner,loser)
  puts "Congrats #{winner}! You won the game!"
  puts "Drat of all drats #{loser}! You lost :("

end

def complete_game(player1,player2,player1_picks,player2_picks)
  if(win?(player1_picks))
    game_results(player1,player2)
  elsif(win?(player2_picks))
    game_results(player2,player1)
  else
    puts "It's a draw. You both lost :/"
  end
end

def play_again?
  ## TODO
end

def play_tictactoe(board)
  num_players = greeting
  player1 = get_player_name(1)
  player2 = get_player_name(2)
  player1_picks = []
  player2_picks = []
  current_player = player1
  current_marker = PLAYER1_MARKER
  current_picks = player1_picks
  show_board(board)
  until game_over?(player1_picks,player2_picks)
    pick = get_pick(current_player,board)
    current_picks.push(pick)
    board = update_board(pick,current_marker,board)
    show_board(board)
    if(current_player == player1)
      current_player = player2
      current_marker = PLAYER2_MARKER
      current_picks = player2_picks
    else
      current_player = player1
      current_marker = PLAYER1_MARKER
      current_picks = player1_picks
    end
  end
  complete_game(player1,player2,player1_picks,player2_picks)
  play_again?
end

play_tictactoe(board)

