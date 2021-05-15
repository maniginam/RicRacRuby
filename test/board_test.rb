# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/board'

# Test program minimax
class BoardTest < Minitest::Test
  def test_is_game_over_empty_board
    board = Board.new
    board.board = %i[0 1 2 3 4 5 6 7 8]
    assert_equal false, board.is_game_over?
  end

  def test_is_game_over_full_board
    board = Board.new
    board.board = %w[X O X X O O O X X]
    assert_equal true, board.is_game_over?
  end
end

