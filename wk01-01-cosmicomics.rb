require 'pry'

def anagram?(word1,word2)
  word1.chars.sort == word2.chars.sort
end

def joiner?(word1,word2)
  word1[-1] == word2[0]
end

def funny_word?(word1,word2)
  anagram?(word1,word2) && joiner?(word1,word2)
end

def join_words(word1,word2)
  word1 + word2[1..-1]
end

def build_dictionary(file)
  dict = Hash.new([]) # new hash, empty
  file.each_line do |line| # loop over each line inf file
    word = line.chomp # chomp each word
    if word.length>3  #only if length > 3
      dict[word.length] += [word]  # add to hash under that key
    end
  end
  dict
end

def find_funny_words(filepath)
  # putting the file.open into a do block, will automtically close the file when it leaves the block
  File.open(filepath, 'r') do |file|
    word_groups = build_dictionary(file)
    word_groups.each do |length,words|
      words.combination(2).each do |word1,word2|
        puts join_words(word1,word2) if funny_word?(word1,word2)
      end
    end
  end
end

find_funny_words("english-dict.txt")