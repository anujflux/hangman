require 'pry'

$stdout.sync = true

class Hangman
  WORD_LIST = ['hangman']
  MAX_LIVES = 5

  def initialize
    @letters_guessed = []
    @lives_lost = 0
  end

  def select_word
    @current_word = WORD_LIST.sample
  end

  def display_dashes_with_correct_guesses
    @current_word.split("").each do |letter|
      if @letters_guessed.include?(letter)
        print letter
      else
        print "-"
      end
      print ""
    end
    print "\n"
  end

  def display_dashes
    # This can do more and bit better
    @current_word.split.each do |part_of_word|
      print "_" * part_of_word.length
      print " "
    end
  end

  def show_message_and_continue(message)
    puts message
  end

  def start_game
    while user_input = get_user_input do
      if user_input == "exit"
        abort_game "Bye, see you next time !"
      elsif user_input.length > 1
        show_message_and_continue "You can only guess one letter at a time"
      else
        check_lives_remaining
        validate_guess(user_input) unless letter_already_guessed?(user_input)
        if has_won?
          binding.pry
          show_message_and_continue "You have won ! See you next time !"
          exit
        end
      end
    end
  end

  def get_user_input
    puts "\nGuess a letter\n"
    gets.chomp
  end

  def validate_guess(letter)
    @letters_guessed.push(letter)
    if is_guess_correct_or_wrong?(letter)
      show_message_and_continue "Correct guess"
    else
      life_lost
      show_message_and_continue "Incorrect guess, please try again. You now have #{lives_remaining} lives left"
    end
    display_dashes_with_correct_guesses
  end

  def life_lost
    @lives_lost = @lives_lost + 1
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

  def load_game
    select_word
    display_welcome_message
    display_dashes
    start_game
  end

  def display_welcome_message
    show_message_and_continue "Welcome to Hangman!!"
    show_message_and_continue "You are guessing a word of #{@current_word.length} letters"
    show_message_and_continue "You have #{MAX_LIVES} guesses"
    show_message_and_continue "Type exit at anytime to quit the game"
  end

  def check_lives_remaining
    if lives_remaining <= 1
      abort_game("You do not have enought lives left to continue the game")
    end
  end

  def lives_remaining
    MAX_LIVES - @lives_lost
  end

  def abort_game(reason)
    puts reason
    exit
  end

  def has_won?
    @current_word.split("").sort == @letters_guessed.sort
  end
end

new_game = Hangman.new
new_game.load_game

  ## DONE: Refactor based on catchup
  ## DONE: Display to the user how long the word is
  ## DONE: Ask the user to select a letter
  ## DONE: Identify whether the letter has already been used or whether the letter is part of the word or not


  ## DONE: Display the dashes and correct guessed words after every letter guessed
  ## TODO: Let the user know whether when they win
  ## TODO: Show the correct word when the user loses the game
  ## DONE: Add maximum guesses allowed feature

  ## LATER: Write some rspecs
  ## LATER: Restart a game
  ## LATER: Start a new game after the current game finishes
  ## LATER: Metrics - win, loses, quits etc.
