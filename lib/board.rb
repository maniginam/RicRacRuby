# frozen_string_literal: true

# board
class Board
  attr_accessor :board, :wins

  def initialize
    @board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    @wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  end

  def is_win?
    is_win = false
    wins.each do |win|
      # line = []
      # win.map { |box| line >> @board[box]}
      # is_win = true if line.uniq.count == 1
      is_win = true if @board[win[0]] == @board[win[1]] && @board[win[1]] == @board[win[2]]
    end
    is_win
  end

  def board_full?
    @board.uniq(&:class)
  end

  def game_over?
    box = 0
    box += 1 until is_win? || board_full?
    board[box].is_a?(String)
  end
end
