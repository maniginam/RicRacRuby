# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/board'

# Test program minimax
class BoardTest < Minitest::Test
  def test_empty_board_not_game_over?
    board = Board.new
    board.board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    assert_equal false, board.is_game_over?
  end
end

