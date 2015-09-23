require "pry"

word_list = [
    "cat", "chick", "duck", "cat", "clown", "brick", "bananas",
    "coffee", "totalitarianism", "metacircular", "interpreter",
    "wednesday", "ruby", "evaluation", "consternation", "chicanery"
]

def greeting
  puts "--------------------------"
  puts "Welcome to Hangman!"
  puts "Time to start guessing."
  puts"--------------------------"
  puts "\n\n"
end

def game_over?(turn_count,answer,guesses)
  win?(answer,guesses) || turn_count==0
end

def win?(answer,guesses)
  answer.chars.all? {|char| guesses.include?(char)}
  # winner = true
  # answer.chars.each.do |letter|
  #   winner = false unless guesses.include?(letter)
  # end
  # winner
end

def prompt_player(guesses)
  valid_letters = ("a".."z").to_a
  puts
  puts "Please guess a letter: "
  guess = gets.chomp
  #binding.pry
  until (valid_letters.include?(guess) && !guesses.include?(guess))
    puts "You either repeated a previous guess or did not enter a character between a and z. Try again!"
    puts
    puts "Please guess a letter: "
    guess = gets.chomp
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
  puts "Play again? (y or n)"
  replay = gets.chomp.downcase
  until replay == "y" || replay == "n"
    puts "\nPlease enter y or n"
    puts "Play again? (y or n)"
    replay = gets.chop.downcase
  end
  replay
end

def hangman(word_list)
  turn_count = 6
  answer = word_list.sample
  guesses = []
  greeting
  until game_over?(turn_count,answer,guesses)
    guess = take_turn(guesses,answer,turn_count)
    guesses.push(guess.downcase) # accounting for upper vs. lowercase, all of our pre-set words are lowercase
    turn_count-=1 unless answer.include?(guess)
  end
  replay = postmortem(answer,guesses)
  hangman(word_list) unless replay=="n"
end

hangman(word_list)