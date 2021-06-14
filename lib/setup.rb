# frozen_string_literal: true

require_relative 'ai_player'
require_relative 'human_player'

class Setup
  attr_accessor :gui, :tokens, :num_of_humans, :human, :player1, :player2, :board

  def initialize(gui, tokens)
    @gui = gui
    @tokens = tokens
  end

  def set_num_of_humans
    @num_of_humans = @gui.prompt_player_count
  end

  def set_players
    case @num_of_humans
    when 0
      @player1 = AiPlayer.new(tokens[0], 10)
      @player2 = AiPlayer.new(tokens[1], -10)
    when 2
      @player1 = HumanPlayer.new(tokens[0], 10)
      @player2 = HumanPlayer.new(tokens[1], -10)
    else
      human = @gui.prompt_player_selection(tokens)
      if human == tokens[0]
        @player1 = HumanPlayer.new(tokens[0], 10)
        @player2 = AiPlayer.new(tokens[1], -10)
      else
        @player1 = AiPlayer.new(tokens[0], 10)
        @player2 = HumanPlayer.new(tokens[1], -10)
      end
    end
  end

  def setup_game
    set_num_of_humans until !@num_of_humans.nil? && @num_of_humans.zero? || @num_of_humans == 1 || @num_of_humans == 2
    set_players
    puts @gui.player_count_response
    @board = Board.new([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end
end
