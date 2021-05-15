# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/board'

# Test program minimax
class BoardTest < Minitest::Test
  def test_game_over_empty_board
    board = Board.new
    board.board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    assert_equal false, board.is_win?
    assert_equal false, board.game_over?
  end

  def test_game_over_one_box_played
    board = Board.new
    board.board = [0, 1, 2, 3, "X", 5, 6, 7, 8]
    assert_equal false, board.is_win?
    assert_equal false, board.game_over?
  end

  def test_game_over_cats_game
    board = Board.new
    board.board = %w[X O X X O O O X X]
    assert_equal false, board.is_win?
    assert_equal true, board.game_over?
  end

  def test_is_game_over_x_wins
    board = Board.new
    board.board = ['X', 'X', 'X', 3, 'O', 'X', 'O', 'X', 'X']
    assert_equal true, board.is_win?
    assert_equal true, board.game_over?
  end

  def test_game_over_o_wins
    board = Board.new
    board.board = ['O', 'O', 'O', 3, 'X', 'O', 'X', 'O', 'O']
    assert_equal true, board.is_win?
    assert_equal true, board.game_over?
  end
end

