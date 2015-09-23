require "pry"
require "set"

word_list = [
    "cat", "chick", "duck", "cat", "clown", "brick", "bananas",
    "coffee", "totalitarianism", "metacircular", "interpreter",
    "wednesday", "ruby", "evaluation", "consternation", "chicanery"
]
turn_count = 6
answer = word_list.sample

def greeting
  puts "--------------------------"
  puts "Welcome to Hangman!"
  puts "Time to start guessing."
  puts"--------------------------"
  puts "\n\n"
end

def game_over?(turn_count,answer,guesses)
  win?(answer,guesses) || turn_count.zero? # turn_count==0
end

def win?(answer,guesses)
  answer.chars.all? {|char| guesses.include?(char)}
  # winner = true
  # answer.chars.each.do |letter|
  #   winner = false unless guesses.include?(letter)
  # end
  # winner
end

def get_letter()
  puts
  puts "Please guess a letter: "
  gets.chomp.downcase
end

def valid_guess?(guesses, letter)
  valid_letters = ("a".."z").to_a
  if(!valid_letters.include?(letter))
    puts "The guess it not a single letter between a and z!  Try again."
    false
  elsif(guesses.include?(letter))
    puts "You already guessed #{letter}! Try again!"
    false
  else
    true
  end
end

def prompt_player(guesses)
  #binding.pry
  guess = get_letter
  until valid_guess?(guesses,guess)
    guess = get_letter
  end
  guess
end

def show_progress(partial,turn_count)
  puts "The current word is: #{partial}."
  puts "You have #{turn_count} guesses left."
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

def take_turn(guesses,answer,turn_count)
  partial = make_partial(guesses,answer).join
  show_progress(partial,turn_count)
  prompt_player(guesses)
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

def play_hangman(words,turns)
  answer = words.sample
  hangman(answer,turns)
  while play_again?
    hangman(answer,turns)
  end
end

def hangman(answer,turn_count)
  guesses = Set.new
  greeting
  until game_over?(turn_count,answer,guesses)
    guess = take_turn(guesses,answer,turn_count).downcase
    guesses.add(guess) # accounting for upper vs. lowercase, all of our pre-set words are lowercase
    turn_count-=1 unless answer.include?(guess)
  end
  postmortem(answer,guesses)
end

play_hangman(word_list,turn_count)