# frozen_string_literal: true

# board
class Board
  attr_accessor :board

  def initialize
    @board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def is_game_over?
    box = 0
    box += 1 until board[box].is_a?(Integer) || box < board.size
    board[box].is_a?(String)
  end
end
