# frozen_string_literal: true

require_relative 'gui'

# Terminal
class Terminal < Gui
  attr_accessor :num_of_humans, :human

  def welcome
    puts 'Welcome to Tic-Tac-Ruby-o'
  end

  def prompt_player_count
    puts 'How many humans will be playing?'
    @num_of_humans = gets.chomp.to_i
  end

  def player_count_response
    if @num_of_humans.zero?
      "Ok.  I will play for yet another cat's game against myself..."
    elsif @num_of_humans == 2
      'May the best player win!'
    else
      "May the odds be eva' in your favor!"
    end
  end

  def valid_token?(tokens, token_selection)
    token_selection == tokens[0] || token_selection == tokens[1]
  end

  def set_human(tokens, token_selection)
    if valid_token?(tokens, token_selection.upcase)
      @human = token_selection
      ai = if @human == tokens[0]
             tokens[1]
           else
             tokens[0]
           end
      puts String("Alright, I'll be #{ai}")
    else
      @human = tokens[1]
      puts String("That wasn't an option, so I'll be #{tokens[0]} and you can be #{tokens[1]}!")
    end
  end

  def prompt_player_selection(tokens)
    puts String("Do you want to be #{tokens[0]} or #{tokens[1]}?")
    set_human(tokens, gets.chomp)
  end

  def draw_board(board)
    String("  #{board[0]} | #{board[1]} | #{board[2]}  \n ----------- \n  #{board[3]} | #{board[4]} | #{board[5]} \n ----------- \n  #{board[6]} | #{board[7]} | #{board[8]} \n")
  end

  def prompt_box_selection
    puts 'Select a box'
    gets.chomp.to_i
  end

  def show_turn(player, board)
    puts draw_board(board)
    puts String("#{player.token}'s Turn!")
  end

  def show_win(board, player)
    if player.nil?
      puts "\nCat's Game"
    else
      puts "\n#{player.token} Wins!"
    end
    puts draw_board(board)
  end
end
