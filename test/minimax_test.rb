# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/minimax'

# Test program minimax
class MinimaxTest < Minitest::Test
  # X's Turn: cat's game
  def test_one_box_left
    player = 10
    board = ['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X']
    minimax = Minimax.new(board, player)
    board_scores = minimax.get_box_scores(board)
    # board_scores = ['X', 'O', 'X', 0, 'O', 'O', 'O', 'X', 'X']
    assert_equal ['X', 'O', 'X', 0, 'O', 'O', 'O', 'X', 'X'], board_scores
    assert_equal 3, minimax.choose_best_box(board_scores)
  end

  def test_two_boxes_left
    # O's Turn: box 3 loses, box 5 cats game
    player = -10
    board = ['X', 'O', 'X', 3, 'O', 5, 'O', 'X', 'X']
    minimax = Minimax.new(board, player)
    board_scores = minimax.get_box_scores(board)
    # board_scores = ['X', 'O', 'X', 9, 'O', 0, 'O', 'X', 'X']
    assert_equal ['X', 'O', 'X', 9, 'O', 0, 'O', 'X', 'X'], board_scores
    assert_equal 5, minimax.choose_best_box(board_scores)
  end

  def test_three_boxes_left
    # X's Turn: All but Box 2 could lose
    player = 10
    board = ['X', 'O', 2, 3, 'O', 5, 'O', 'X', 'X']
    minimax = Minimax.new(board, player)
    board_scores = ['X', 'O', 0, -9, 'O', -9, 'O', 'X', 'X']
    assert_equal 2, minimax.choose_best_box(board_scores)
  end

  def test_four_boxes_left
    # O's Turn: not box 6 loses
    player = -10
    board = ['X', 'O', 2, 3, 'O', 5, 6, 'X', 'X']
    minimax = Minimax.new(board, player)
    board_scores = ['X', 'O', 0, 0, 'O', 0, -9, 'X', 'X']
    assert_equal 6, minimax.choose_best_box(board_scores)
  end

  def test_five_boxes_left
    # X's Turn: not box 7 loses
    player = -10
    board = ['X', 'O', 2, 3, 'O', 5, 6, 7, 'X']
    minimax = Minimax.new(board, player)
    board_scores = ['X', 'O', 0, 0, 'O', 0, 0, -9, 'X']
    assert_equal 7, minimax.choose_best_box(board_scores)
  end

  # def test_six_boxes_left
  #   # O's Turn: it gets harder now; should probably break out into real minimax
  #   player = -10
  #   board = ['X', 'O', 2, 3, 'O', 5, 6, 7, 'X']
  #   minimax = Minimax.new(board, player)
  #   board_scores = get_box_scores
  #   assert_equal 7, minimax.choose_best_box(board_scores)
  # end

end
