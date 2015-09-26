require 'pry'

COMPUTER_NAME = "Unimatrix Zero"
PLAYER1_MARKER = "X"
PLAYER2_MARKER = "O"
WINNING_BOARDS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

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
  print "\nHow many players? (1 or 2) "
  num_players = gets.chomp.to_i
  until ((1..2).include?(num_players))
    puts "Please pick 1 or 2 players!"
    print "\nHow many players? (1 or 2) "
  end
  num_players
end

def get_player_name(player)
  print "Player #{player}, enter your name: "
  gets.chomp
end

def get_open(board)
  open_spots = []
  board.each_with_index {|value,index| open_spots.push(index+1) if (value!=PLAYER1_MARKER && value!=PLAYER2_MARKER)}
  open_spots
end

def get_picked(board,marker)
  picked_spots = []
  board.each_with_index {|value,index| picked_spots.push(index+1) if value== marker}
  picked_spots
end

def game_over?(board)
  win?(board,PLAYER1_MARKER) || win?(board,PLAYER2_MARKER) || (get_open(board).empty?)
end

def get_pick
  print "Choose wisely: "
  gets.chomp.to_i
end

def pick_random(board)
  blanks = board - [PLAYER1_MARKER,PLAYER2_MARKER]
  blanks.sample
end

def find_wins(board,marker)
  pick_combos = get_picked(board,marker).sort.combination(2).to_a
  wins = []
  ## TODO make this better, it's very slow
  WINNING_BOARDS.each do |win|
    pick_combos.each do |combo|
      wins.push((win-combo)[0]) if (win - combo).length==1
    end
  end
  wins
end

def get_computer_pick(board)
  print "Thinking...."
  sleep(1)
  puts "Thinking...."
  sleep(1)
  print "find_win output: "
  # any win situations?
  wins = find_wins(board,PLAYER2_MARKER)
  # any lose situations?
  losses = find_wins(board,PLAYER1_MARKER)
  # is center open?
  open_spots = get_open(board)
  center = open_spots.include?(4)
  # opponent corner, opposite open

  # any corner open?

  if !wins.empty?
    wins.sample
  elsif !losses.empty?
    losses.sample
  elsif center
    4 #return the center position
  else
    pick_random(board)
  end
end

def valid_pick?(pick,board)
  board.include?(pick) && (1..9).include?(pick)
end

def take_turn(player,board,marker)
  puts "#{player}, it's your turn!"
  player==COMPUTER_NAME ? pick=get_computer_pick(board) : pick=get_pick
  until valid_pick?(pick,board)
    puts "Hey! That spot has already been claimed or your entry isn't between 1 and 9!"
    # theoretically only a real player should get here
    pick=get_pick
  end
  puts "#{player} chose #{pick}."
  update_board(pick,marker,board)
end

def update_board(pick,marker,board)
  board[pick-1] = marker
  show_board(board)
  board
end

def win?(board,marker)
  picks = get_picked(board,marker)
  pick_combos = picks.sort.combination(3).to_a
  !(pick_combos & WINNING_BOARDS).empty?
end

def game_results(winner,loser)
  puts "\nCongrats #{winner}! You won the game!"
  puts "Drat of all drats #{loser}! You lost :("

end

def complete_game(board,player1,player2)
  if(win?(board,PLAYER1_MARKER))
    game_results(player1,player2)
  elsif(win?(board,PLAYER2_MARKER))
    game_results(player2,player1)
  else
    puts "It's a draw. You both lost :/"
  end
end

def play_again?
  puts "Play again? (y or n)"
  replay = gets.chomp.downcase
  until replay == "y" || replay == "n"
    puts "\nPlease enter y or n"
    puts "Play again? (y or n)"
    replay = gets.chop.downcase
  end
  replay == "y"
end

def tictactoe
  board = (1..9).to_a
  num_players = greeting
  player1 = get_player_name(1)
  if(num_players==2)
    player2 = get_player_name(2)
    until player1.downcase!=player2.downcase
      puts "Sorry, but Player 1's name cannot equal Player 2's name!"
      player2 = get_player_name(2)
    end
  else
    player2 = COMPUTER_NAME
  end
  current_player = player1
  current_marker = PLAYER1_MARKER
  show_board(board)
  until game_over?(board)
    board = take_turn(current_player,board,current_marker)
    if(current_player == player1)
      current_player = player2
      current_marker = PLAYER2_MARKER
    else
      current_player = player1
      current_marker = PLAYER1_MARKER
    end
  end
  complete_game(board,player1,player2)
end

def play_tictactoe
  tictactoe
  while play_again?
    tictactoe
  end
end

play_tictactoe