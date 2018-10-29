require 'pry'

$stdout.sync = true

class Hangman
  @word_list


  def initialize
    @word_list = ["Virat Kohli", "Sachin Tendulkar"]
    @letters_guessed = Array.new
    @correct_letters = Array.new
  end

  def select_word
    @current_word = @word_list[Random.rand(@word_list.length)]
    @current_word.split.each do |part_of_word|
      part_of_word.split('').each do |letter|
        @correct_letters.push(letter)
      end
    end
    @current_word

    @correct_letters
  end


  def user_input
    letter = nil
    p "Guess a letter"
    letter = gets.chomp
  end

  def display
    @current_word.split.each do |part_of_word|
      print "_" * part_of_word.length
      print " "
    end
  end

  ## TODO: Display to the user how long the word is
  ## TODO: Ask the user to select a letter
  ## TODO: Identify whether the letter has already been used or whether the letter is part of the word or not
end

new_game = Hangman.new
p new_game.select_word
new_game.display
