# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/minimax'
require_relative '../lib/board'
require_relative '../lib/gui'
require_relative 'spec_helper'

# Test program minimax
class MinimaxTest < Minitest::Test
  attr_accessor :minimax, :board, :player1, :player2, :player1_obj, :player2_obj

  def init_game(board)
    @board = Board.new(board)
    @player1 = { token: 'X', score: 10 }
    @player2 = { token: 'O', score: -10 }
    @minimax = Minimax.new(@board.board, [@player1, @player2])
  end

  # X's Turn: cat's game
  def test_one_box_left
    init_game(['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X'])
    minimax.score_boxes(@board, @player1, 0)
    assert_equal ['X', 'O', 'X', 0, 'O', 'O', 'O', 'X', 'X'], minimax.board_scores
    assert_equal 3, minimax.choose_best_box(@player1)
  end

  def test_two_boxes_left
    # O's Turn: box 3 loses, box 5 cats game
    init_game(['X', 'O', 'X', 3, 'O', 5, 'O', 'X', 'X'])
    minimax.score_boxes(@board, @player2, 0)
    box_3_score = minimax.score_box(Board.new(['X', 'O', 'X', 'O', 'O', 5, 'O', 'X', 'X']), @player2, 0)
    box_5_score = minimax.score_box(Board.new(['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X']), @player2, 0)
    assert_equal 9, box_3_score
    assert_equal 0, box_5_score
    assert_equal ['X', 'O', 'X', 9, 'O', 0, 'O', 'X', 'X'], minimax.board_scores
    assert_equal 5, minimax.choose_best_box(@player2)
  end

  def test_three_boxes_left
    # X's Turn: All but Box 2 could lose
    init_game(['X', 'O', 2, 3, 'O', 5, 'O', 'X', 'X'])
    minimax.score_boxes(@board, @player1, 0)
    box_2_score = minimax.score_box(Board.new(['X', 'O', 'X', 3, 'O', 5, 'O', 'X', 'X']), @player1, 0)
    box_3_score = minimax.score_box(Board.new(['X', 'O', 2, 'X', 'O', 5, 'O', 'X', 'X']), @player1, 0)
    box_5_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 'X', 'O', 'X', 'X']), @player1, 0)
    assert_equal 0, box_2_score
    assert_equal(-9, box_3_score)
    assert_equal(-9, box_5_score)
    assert_equal ['X', 'O', 0, -9, 'O', -9, 'O', 'X', 'X'], minimax.board_scores
    assert_equal 2, minimax.choose_best_box(@player1)
  end

  def test_four_boxes_left
    # O's Turn: not box 6 loses
    init_game(['X', 'O', 2, 3, 'O', 5, 6, 'X', 'X'])
    minimax.score_boxes(@board, @player2, 0)
    box_2_score = minimax.score_box(Board.new(['X', 'O', 'O', 3, 'O', 5, 6, 'X', 'X']), @player2, 0)
    box_3_score = minimax.score_box(Board.new(['X', 'O', 2, 'O', 'O', 5, 6, 'X', 'X']), @player2, 0)
    box_5_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 'O', 6, 'X', 'X']), @player2, 0)
    box_6_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 5, 'O', 'X', 'X']), @player2, 0)
    assert_equal 9, box_2_score
    assert_equal 9, box_3_score
    assert_equal 9, box_5_score
    assert_equal 0, box_6_score
    assert_equal ['X', 'O', 9, 9, 'O', 9, 0, 'X', 'X'], minimax.board_scores
    assert_equal 6, minimax.choose_best_box(@player2)
  end

  def test_five_boxes_left
    # X's Turn: not box 7 loses
    init_game(['X', 'O', 2, 3, 'O', 5, 6, 7, 'X'])
    minimax.score_boxes(@board, @player1, 0)
    box_2_score = minimax.score_box(Board.new(['X', 'O', 'X', 3, 'O', 5, 6, 7, 'X']), @player1, 0)
    box_3_score = minimax.score_box(Board.new(['X', 'O', 2, 'X', 'O', 5, 6, 7, 'X']), @player1, 0)
    box_5_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 'X', 6, 7, 'X']), @player1, 0)
    box_6_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 5, 'X', 7, 'X']), @player1, 0)
    box_7_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 5, 6, 'X', 'X']), @player1, 0)
    assert_equal(-9, box_2_score)
    assert_equal(-9, box_3_score)
    assert_equal(-9, box_5_score)
    assert_equal(-9, box_6_score)
    assert_equal 0, box_7_score
    assert_equal ['X', 'O', -9, -9, 'O', -9, -9, 0, 'X'], minimax.board_scores
    assert_equal 7, minimax.choose_best_box(@player1)
  end

  def test_six_boxes_left
    # O's Turn: it gets harder now; should probably break out into real minimax
    init_game(['X', 1, 2, 3, 'O', 5, 6, 7, 'X'])
    minimax.score_boxes(@board, @player2, 0)
    box_1_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 'O', 5, 6, 7, 'X']), @player2, 0)
    box_2_score = minimax.score_box(Board.new(['X', 1, 'O', 3, 'O', 5, 6, 7, 'X']), @player2, 0)
    box_3_score = minimax.score_box(Board.new(['X', 1, 2, 'O', 'O', 5, 6, 7, 'X']), @player2, 0)
    box_5_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 'O', 6, 7, 'X']), @player2, 0)
    box_6_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 'O', 7, 'X']), @player2, 0)
    box_7_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 'O', 'X']), @player2, 0)
    assert_equal 0, box_1_score
    assert_equal 7, box_2_score
    assert_equal 0, box_3_score
    assert_equal 0, box_5_score
    assert_equal 7, box_6_score
    assert_equal 0, box_7_score
    assert_equal ['X', 0, 7, 0, 'O', 0, 7, 0, 'X'], minimax.board_scores
    assert_equal 1, minimax.choose_best_box(@player2)
  end

  def test_seven_boxes_left
    # X's Turn
    init_game(['X', 1, 2, 3, 'O', 5, 6, 7, 8])
    minimax.score_boxes(@board, @player1, 0)
    box_1_score = minimax.score_box(Board.new(['X', 'X', 2, 3, 'O', 5, 6, 7, 8]), @player1, 0)
    box_2_score = minimax.score_box(Board.new(['X', 1, 'X', 3, 'O', 5, 6, 7, 8]), @player1, 0)
    box_3_score = minimax.score_box(Board.new(['X', 1, 2, 'X', 'O', 5, 6, 7, 8]), @player1, 0)
    box_5_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 'X', 6, 7, 8]), @player1, 0)
    box_6_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 'X', 7, 8]), @player1, 0)
    box_7_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 'X', 8]), @player1, 0)
    box_8_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 'X']), @player1, 0)
    assert_equal 0, box_1_score
    assert_equal 0, box_2_score
    assert_equal 0, box_3_score
    assert_equal 0, box_5_score
    assert_equal 0, box_6_score
    assert_equal 0, box_7_score
    assert_equal 0, box_8_score
    assert_equal ['X', 0, 0, 0, 'O', 0, 0, 0, 0], minimax.board_scores
    assert_equal 1, minimax.choose_best_box(@player1)
  end

  def test_eight_boxes_left
    # O's Turn
    init_game(['X', 1, 2, 3, 4, 5, 6, 7, 8])
    minimax.score_boxes(@board, @player2, 0)
    box_1_score = minimax.score_box(Board.new(['X', 'O', 2, 3, 4, 5, 6, 7, 8]), @player2, 0)
    box_2_score = minimax.score_box(Board.new(['X', 1, 'O', 3, 4, 5, 6, 7, 8]), @player2, 0)
    box_3_score = minimax.score_box(Board.new(['X', 1, 2, 'O', 4, 5, 6, 7, 8]), @player2, 0)
    box_4_score = minimax.score_box(Board.new(['X', 1, 2, 3, 'O', 5, 6, 7, 8]), @player2, 0)
    box_5_score = minimax.score_box(Board.new(['X', 1, 2, 3, 4, 'O', 6, 7, 8]), @player2, 0)
    box_6_score = minimax.score_box(Board.new(['X', 1, 2, 3, 4, 5, 'O', 7, 8]), @player2, 0)
    box_7_score = minimax.score_box(Board.new(['X', 1, 2, 3, 4, 5, 6, 'O', 8]), @player2, 0)
    box_8_score = minimax.score_box(Board.new(['X', 1, 2, 3, 4, 5, 6, 7, 'O']), @player2, 0)
    assert_equal 5, box_1_score
    assert_equal 5, box_2_score
    assert_equal 5, box_3_score
    assert_equal 0, box_4_score
    assert_equal 5, box_5_score
    assert_equal 5, box_6_score
    assert_equal 5, box_7_score
    assert_equal 5, box_8_score
    assert_equal ['X', 5, 5, 5, 0, 5, 5, 5, 5], minimax.board_scores
    assert_equal 4, minimax.choose_best_box(@player2)
  end

  def test_always_wins!
    init_game(['X', 'X', 2, 3, 4, 5, 6, 7, 8])
    minimax.score_boxes(@board, @player1, 0)
    assert_equal ['X', 'X', 10, 8, 8, 6, 8, 8, 8], minimax.board_scores
    assert_equal 2, minimax.choose_best_box(@player1)
  end

  def test_always_wins_over_cat!
    init_game(['X', 'X', 2, 3, 4, 5, 'O', 'O', 8])
    minimax.score_boxes(@board, @player1, 0)
    assert_equal ['X', 'X', 10, -9, -9, -9, 'O', 'O', 8], minimax.board_scores
    assert_equal 2, minimax.choose_best_box(@player1)
  end

  def test_too_good_to_lose!
    init_game(['X', 'X', 2, 3, 4, 5, 6, 7, 8])
    minimax.score_boxes(@board, @player2, 0)
    assert_equal ['X', 'X', 7, 9, 9, 9, 9, 9, 9], minimax.board_scores
    assert_equal 2, minimax.choose_best_box(@player2)
  end
end
