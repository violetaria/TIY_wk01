require "pry"
require "set"

word_list = [
    "cat", "chick", "duck", "cat", "clown", "brick", "bananas",
    "coffee", "totalitarianism", "metacircular", "interpreter",
    "wednesday", "ruby", "evaluation", "consternation", "chicanery"
]
MAX_TURNS = 6
answer = word_list.sample

def greeting
  puts "--------------------------"
  puts "Welcome to Hangman!"
  puts "Time to start guessing."
  puts"--------------------------"
  puts "\n\n"
end

def game_over?(answer,guesses)
  win?(answer,guesses) || turns_left(answer,guesses).zero? # turn_count==0
end

def win?(answer,guesses)
  answer_set = answer.chars.to_set
  guesses >= answer_set

  # attempt 4
  # guesses.superset? answer_set

  # attempt 3 below
  # answer_set.subset? guesses

  # attempt 2 below
  # answer.chars.all? {|char| guesses.include?(char)}


  # attempt 1 below
  # # winner = true
  # answer.chars.each.do |letter|
  #   winner = false unless guesses.include?(letter)
  # end
  # winner
end

def get_letter
  puts
  puts "Please guess a letter: "
  gets.chomp.downcase
end

def valid_guess?(letter)
  valid_letters = ("a".."z").to_a
  if(!valid_letters.include?(letter))
    puts "The guess it not a single letter between a and z!  Try again."
    false
  # elsif(guesses.include?(letter))
  #   puts "You already guessed #{letter}! Try again!"
  #   false
  else
    true
  end
end

def prompt_player
  #binding.pry
  guess = get_letter
  until valid_guess?(guess)
    guess = get_letter
  end
  guess
end

def show_progress(partial,answer,guesses)
  turns_remaining = turns_left(answer, guesses)
  puts "The current word is: #{partial}."
  puts "You have #{turns_remaining} guesses left."
end

def make_partial(guesses,answer)
  answer.chars.map do |letter|
    if guesses.include?(letter)
      letter
    else
      "_"
    end
  end
end

def take_turn(guesses,answer)
  partial = make_partial(guesses,answer).join
  show_progress(partial,answer,guesses)
  prompt_player
end

def postmortem(answer, guesses)
  puts win?(answer,guesses) ?  "Slowclap - Congrats, YOU WON!" : "You lost which kinda sucks! Better luck next time."
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
    hangman(answer)
  end
end

def turns_left(answer,guesses)
  answer_set = answer.chars.to_set
  wrong_guesses = (guesses - answer_set).count

  # attempt 1
  # wrong_guesses = guesses.difference(answer_set).count

  #binding.pry
  MAX_TURNS - wrong_guesses
end

def hangman(answer)
  guesses = Set.new
  greeting
  until game_over?(answer,guesses)
    guess = take_turn(guesses,answer).downcase
    guesses.add(guess) # accounting for upper vs. lowercase, all of our pre-set words are lowercase
  end
  postmortem(answer,guesses)
end

play_hangman(word_list)