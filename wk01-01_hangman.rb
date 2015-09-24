require "pry"
require "set"

word_list = [
    "cat", "chick", "duck", "cat", "clown", "brick", "bananas",
    "coffee", "totalitarianism", "metacircular", "interpreter",
    "wednesday", "ruby", "evaluation", "consternation", "chicanery"
]
MAX_TURNS = 6
player1 = nil
player2 = nil
DEBUG = false

def greeting(player1, player2)
  puts "--------------------------"
  puts "Welcome to Hangman!"
  puts "#{player1} and #{player2}, are you ready for a head to head game?"
  puts "Time to start guessing."
  puts"--------------------------\n"
end

def game_over?(answer,guesses)
  win?(answer,guesses) || turns_left(answer,guesses).zero? # turn_count==0
end

def win?(answer,guesses)
  answer_set = answer.chars.to_set
  guesses >= answer_set
end

def get_letter
  puts
  print "Please guess a letter: "
  gets.chomp.downcase
end

def valid_guess?(letter)
  valid_letters = ("a".."z").to_a
  if(!valid_letters.include?(letter))
    puts "The guess is not a single letter between a and z!  Try again."
    false
  else
    true
  end
end

def prompt_player
  guess = get_letter
  until valid_guess?(guess)
    guess = get_letter
  end
  guess
end

def show_progress(partial,answer,guesses,current_player)
  turns_remaining = turns_left(answer, guesses)
  puts "==> #{current_player}, it's your turn. You have #{turns_remaining} guesses left."
  puts "The current word is: #{partial}."
end

def make_partial(guesses,answer)
  answer_set = answer.chars.to_set
  missing = (answer_set - guesses).to_a.join
  answer.gsub(/[#{missing}]/, "_")
end

def take_turn(guesses,answer,current_player)
  partial = make_partial(guesses,answer)
  show_progress(partial,answer,guesses,current_player)
  prompt_player
end

def postmortem(answer, guesses, current_player)
  puts win?(answer,guesses) ?  "Slowclap - Congrats #{current_player}, YOU WON!" : "#{current_player}, you LOSE which kinda sucks! Better luck next time."
  puts "The word was: #{answer}."
  puts
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

def play_hangman(words)
  answer = words.sample
  hangman(answer)
  while play_again?
    answer = words.sample
    hangman(answer)
  end
end

def turns_left(answer,guesses)
  answer_set = answer.chars.to_set
  wrong_guesses = (guesses - answer_set).count
  MAX_TURNS - wrong_guesses
end

def get_name(player)
  print "Player #{player}, please enter your name: "
  gets.chomp
end

def hangman(answer)
  player1_guesses = Set.new
  player2_guesses = Set.new
  player1 = get_name(1)
  player2 = get_name(2)
  greeting(player1, player2)
  # player one goes first
  current_player = player1
  current_guesses = player1_guesses
  until game_over?(answer,current_guesses)
    # turn stuff for current player
    guess = take_turn(current_guesses,answer,current_player).downcase # accounting for upper vs. lowercase, all of our pre-set words are lowercase
    current_guesses.add(guess)
    # switch turns
    if(!answer.include?(guess))
      if(current_player == player1)
        current_guesses = player2_guesses
        current_player = player2
      else
        current_guesses = player1_guesses
        current_player = player1
      end
    end
  end
  postmortem(answer,current_guesses,current_player)
end

play_hangman(word_list)