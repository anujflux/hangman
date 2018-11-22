require 'pry'

$stdout.sync = true

class Hangman
  WORD_LIST = ['hangman']


  def initialize
    @letters_guessed = []
  end

  def select_word
    @current_word = WORD_LIST.sample
  end

  def display_dashes
    @current_word.split.each do |part_of_word|
        print "_" * part_of_word.length
        print " "
      end
  end

  def get_user_input
    while letter = gets.chomp
      case letter
      when "exit"
        exit
      else
        validate_guess(letter) unless letter_already_guessed?(letter)
      end
    end
  end

  def validate_guess(letter)
    @letters_guessed.push(letter)
    if is_guess_correct_or_wrong?(letter)
      puts "Correct guess"
    else
      puts "Incorrect guess, please try again"
    end
  end

  def letter_already_guessed?(letter)
    if @letters_guessed.include?(letter)
      puts "Letter guessed before as well, please select another letter"
      puts "Here are all the letters you have already guessed: "
      puts @letters_guessed
      return true
    else
      return false
    end
  end

  def is_guess_correct_or_wrong?(letter)
    return @current_word.include?(letter)
  end


  ## DONE: Refactor based on catchup
  ## DONE: Display to the user how long the word is
  ## DONE: Ask the user to select a letter
  ## DONE: Identify whether the letter has already been used or whether the letter is part of the word or not
end

new_game = Hangman.new
new_game.select_word
new_game.display_dashes
puts "\nGuess a letter\n"
new_game.get_user_input
