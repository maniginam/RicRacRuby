# frozen_string_literal: true

# board
class Board
  attr_accessor :board, :wins

  def initialize(board)
    @board = board
    @wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  end

  def is_win?
    is_win = false
    wins.each do |win|
      is_win = true if @board[win[0]] == @board[win[1]] && @board[win[1]] == @board[win[2]]
    end
    is_win
  end

  def board_full?
    @board.uniq.count == 2
  end

  def box_available(box)
    unless box.nil?
      @board[box] == box
    end
  end

  def game_over?
    is_win? || board_full?
  end
end
