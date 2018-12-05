require 'pry'

$stdout.sync = true

class Hangman
  WORD_LIST = ['hangman']
  MAX_GUESSES = 5

  def initialize
    @correct_letters_guessed = []
    @incorrect_letters_guessed = []
    @count_incorrect_guesses = 0
  end

  def select_word
    @current_word = WORD_LIST.sample
  end

  def display_dashes_with_correct_guesses
    @current_word.split("").each do |letter|
      if @correct_letters_guessed.include?(letter)
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
    letter_count = count_letters_in_word(letter)
    if letter_count > 0
      letter_count.times do
        @correct_letters_guessed.push(letter)
      end
      show_message_and_continue "Correct guess"
    else
      show_message_and_continue "Incorrect guess !"
      @incorrect_letters_guessed.push(letter)
      incorrect_guess
      show_message_and_continue "You now have #{guesses_remaining} lives left"
    end
    display_dashes_with_correct_guesses
  end

  def incorrect_guess
    @count_incorrect_guesses = @count_incorrect_guesses + 1
    check_guesses_remaining
  end

  def letter_already_guessed?(letter)
    if @correct_letters_guessed.include?(letter)
      puts "Letter guessed before as well, please guess another letter"
      return true
    else
      return false
    end
  end

  def count_letters_in_word(letter)
    return @current_word.count(letter)
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
    show_message_and_continue "You have #{MAX_GUESSES} guesses"
    show_message_and_continue "Type exit at anytime to quit the game"
  end

  def check_guesses_remaining
    if guesses_remaining <= 0
      abort_game("You do not have enough guesses remanining to continue the game\nThe correct word was '#{@current_word}'")
    end
  end

  def guesses_remaining
    MAX_GUESSES - @count_incorrect_guesses
  end

  def abort_game(reason)
    puts reason
    exit
  end

  def has_won?
    @current_word.split("").sort.join == @correct_letters_guessed.sort.join
  end
end

new_game = Hangman.new
new_game.load_game

  ## DONE: Refactor based on catchup
  ## DONE: Display to the user how long the word is
  ## DONE: Ask the user to select a letter
  ## DONE: Identify whether the letter has already been used or whether the letter is part of the word or not


  ## DONE: Display the dashes and correct guessed words after every letter guessed
  ## DONE: Let the user know whether when they win
  ## DONE: Show the correct word when the user loses the game
  ## DONE: Add maximum guesses allowed feature

  ## LATER: Write some rspecs
  ## LATER: Restart a game
  ## LATER: Start a new game after the current game finishes
  ## LATER: Metrics - win, loses, quits etc.
