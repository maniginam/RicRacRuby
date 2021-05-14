# frozen_string_literal: true

# board
class Board
  attr_accessor :board

  def initialize
    @board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def is_game_over?
    game_over = true
    @board.reduce do |box|
      game_over = false if box.is_a?(Integer)
    end
    game_over
  end
end