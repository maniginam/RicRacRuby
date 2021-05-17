# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/minimax'
require_relative '../lib/board'

# Test program minimax
class MinimaxTest < Minitest::Test
  # X's Turn: cat's game
  def test_one_box_left
    board = ['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X']
    player = 10
    minimax = Minimax.new(board, player)
    board_scores = minimax.score_boxes
    assert_equal ['X', 'O', 'X', 0, 'O', 'O', 'O', 'X', 'X'], board_scores
    assert_equal 3, minimax.choose_best_box(board_scores)
  end

  def test_two_boxes_left
    # O's Turn: box 3 loses, box 5 cats game
    board = ['X', 'O', 'X', 3, 'O', 5, 'O', 'X', 'X']
    player = -10
    minimax = Minimax.new(board, player)
    board_scores = minimax.score_boxes
    box_3_score = minimax.score_box(Board.new(['X', 'O', 'X', 'O', 'O', 5, 'O', 'X', 'X']), player, 0)
    box_5_score = minimax.score_box(Board.new(['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X']), player, 0)
    assert_equal 9, box_3_score
    assert_equal 0, box_5_score
    assert_equal ['X', 'O', 'X', 9, 'O', 0, 'O', 'X', 'X'], board_scores
    assert_equal 5, minimax.choose_best_box(board_scores)
  end

  def test_three_boxes_left
    # X's Turn: All but Box 2 could lose
    board = ['X', 'O', 2, 3, 'O', 5, 'O', 'X', 'X']
    player = 10
    minimax = Minimax.new(board, player)
    board_scores = minimax.score_boxes
    box_2_score = minimax.score_box(Board.new(['X', 'O', 'X', 3, 'O', 5, 'O', 'X', 'X']), player, 0)
    box_3_score = minimax.score_box(Board.new(['X', 'O', 2, 'X', 'O', 5, 'O', 'X', 'X']), player, 0)
    box_5_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 'X', 'O', 'X', 'X']), player, 0)
    assert_equal 0, box_2_score
    assert_equal -9, box_3_score
    assert_equal -9, box_5_score
    assert_equal ['X', 'O', 0, -9, 'O', -9, 'O', 'X', 'X'], board_scores
    assert_equal 2, minimax.choose_best_box(board_scores)
  end

  def test_four_boxes_left
    # O's Turn: not box 6 loses
    board = ['X', 'O', 2, 3, 'O', 5, 6, 'X', 'X']
    player = -10
    minimax = Minimax.new(board, player)
    board_scores = minimax.score_boxes
    box_2_score = minimax.score_box(Board.new(['X', 'O', 'O', 3, 'O', 5, 6, 'X', 'X']), player, 0)
    box_3_score = minimax.score_box(Board.new(['X', 'O', 2, 'O', 'O', 5, 6, 'X', 'X']), player, 0)
    box_5_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 'O', 6, 'X', 'X']), player, 0)
    box_6_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 5, 'O', 'X', 'X']), player, 0)
    assert_equal 9, box_2_score
    assert_equal 9, box_3_score
    assert_equal 9, box_5_score
    assert_equal 0, box_6_score
    assert_equal ['X', 'O', 9, 9, 'O', 9, 0, 'X', 'X'], board_scores
    assert_equal 6, minimax.choose_best_box(board_scores)
  end

  def test_five_boxes_left
    # X's Turn: not box 7 loses
    board = ['X', 'O', 2, 3, 'O', 5, 6, 7, 'X']
    player = 10
    minimax = Minimax.new(board, player)
    board_scores = minimax.score_boxes
    box_2_score = minimax.score_box(Board.new(['X', 'O', 'X', 3, 'O', 5, 6, 7, 'X']), player, 0)
    box_3_score = minimax.score_box(Board.new(['X', 'O', 2, 'X', 'O', 5, 6, 7, 'X']), player, 0)
    box_5_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 'X', 6, 7, 'X']), player, 0)
    box_6_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 5, 'X', 7, 'X']), player, 0)
    box_7_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 5, 6, 'X', 'X']), player, 0)
    assert_equal -9, box_2_score
    assert_equal -9, box_3_score
    assert_equal -9, box_5_score
    assert_equal -9, box_6_score
    assert_equal 0, box_7_score
    assert_equal ['X', 'O', -9, -9, 'O', -9, -9, 0, 'X'], board_scores
    assert_equal 7, minimax.choose_best_box(board_scores)
  end

  def test_six_boxes_left
    # O's Turn: it gets harder now; should probably break out into real minimax
    board = ['X', 1, 2, 3, 'O', 5, 6, 7, 'X']
    player = -10
    minimax = Minimax.new(board, player)
    board_scores = minimax.score_boxes
    expected_board_scores = ['X', 0, 7, 0, 'O', 0, 7, 0, 'X']
    box_1_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 5, 6, 7, 'X']), player, 0)
    box_2_score = minimax.score_box(Board.new(['X', 1, 'O', 3, 'O', 5, 6, 7, 'X']), player, 0)
    box_3_score = minimax.score_box(Board.new(['X', 1, 2, 'O', 'O', 5, 6, 7, 'X']), player, 0)
    box_5_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 'O', 6, 7, 'X']), player, 0)
    box_6_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 'O', 7, 'X']), player, 0)
    box_7_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 'O', 'X']), player, 0)
    assert_equal 0, box_1_score
    assert_equal 7, box_2_score
    assert_equal 0, box_3_score
    assert_equal 0, box_5_score
    assert_equal 7, box_6_score
    assert_equal 0, box_7_score
    assert_equal expected_board_scores, board_scores
  end

  def test_seven_boxes_left
    # X's Turn
    board = ['X', 1, 2, 3, 'O', 5, 6, 7, 8]
    player = 10
    minimax = Minimax.new(board, player)
    board_scores = minimax.score_boxes
    box_1_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), player, 0)
    box_2_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), player, 0)
    box_3_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), player, 0)
    box_5_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), player, 0)
    box_6_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), player, 0)
    box_7_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), player, 0)
    box_8_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), player, 0)
    assert_equal 0, box_1_score
    assert_equal 0, box_2_score
    assert_equal 0, box_3_score
    assert_equal 0, box_5_score
    assert_equal 0, box_6_score
    assert_equal 0, box_7_score
    assert_equal 0, box_8_score
    assert_equal ['X', 0, 0, 0, 'O', 0, 0, 0, 0], board_scores
  end

  def test_eight_boxes_left
    # O's Turn
    board = ['X', 1, 2, 3, 4, 5, 6, 7, 8]
    player = -10
    minimax = Minimax.new(board, player)
    board_scores = minimax.score_boxes
    box_1_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 4, 5, 6, 7, 8]), player, 0)
    box_2_score = minimax.score_box(Board.new(['X', 1, 'O', 3, 4, 5, 6, 7, 8]), player, 0)
    box_3_score = minimax.score_box(Board.new(['X', 1, 2, 'O', 4, 5, 6, 7, 8]), player, 0)
    box_4_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), player, 0)
    box_5_score = minimax.score_box(Board.new(['X', 1, 2, 3, 4, 'O', 6, 7, 8]), player, 0)
    box_6_score = minimax.score_box(Board.new(['X', 1, 2, 3, 4, 5, 'O', 7, 8]), player, 0)
    box_7_score = minimax.score_box(Board.new(['X', 1, 2, 3, 4, 5, 6, 'O', 8]), player, 0)
    box_8_score = minimax.score_box(Board.new(['X', 1, 2, 3, 4, 5, 6, 7, 'O']), player, 0)
    assert_equal 5, box_1_score
    assert_equal 5, box_2_score
    assert_equal 5, box_3_score
    assert_equal 0, box_4_score
    assert_equal 5, box_5_score
    assert_equal 5, box_6_score
    assert_equal 5, box_7_score
    assert_equal 5, box_8_score
    assert_equal ['X', 5, 5, 5, 0, 5, 5, 5, 5], board_scores
  end

end
