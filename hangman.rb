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

  def get_user_guess
    puts "\nGuess a letter\n"
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
      puts "Letter guessed before as well, please guess another letter"
      return true
    else
      return false
    end
  end

  def is_guess_correct_or_wrong?(letter)
    return @current_word.include?(letter)
  end

  def start_game
    select_word
    puts "Welcome to Hangman!!"
    puts "You are guessing a word of #{@current_word.length} letters"
    puts "Type exit at anytime to quit the game"
    display_dashes
    get_user_guess
  end


  ## DONE: Refactor based on catchup
  ## DONE: Display to the user how long the word is
  ## DONE: Ask the user to select a letter
  ## DONE: Identify whether the letter has already been used or whether the letter is part of the word or not
  ## TODO: Display the dashes and correct guessed words after every letter guessed
  ## TODO: Let the user know whether when they win
  ## TODO: Add maximum guesses allowed feature
  ## TODO: Restart a game
  ## TODO: Start a new game after the current game finishes
  ## TODO: Metrics - win, loses, quits etc.
end

new_game = Hangman.new
new_game.start_game
