# pick a random number
# take guess input from user
# tell user if guess is higher or lower or correct
# repeat until user guesses correct

randNbr = rand(1...100)
guess = nil

until guess==randNbr
  print "Enter a guess: "
  guess = gets.chomp.to_i
  if(guess < randNbr)
    puts "Your guess of #{guess} is too low! Try again."
  elsif(guess > randNbr)
    puts "Your guess of #{guess} is too high! Try again."
  else
    puts "Your guess of #{guess} is just right! You win!"
  end
end