# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ai_player'
require_relative '../lib/board'
require_relative 'spec_helper'

# Test AI Player
class AiPlayerTest < Minitest::Test
  attr_accessor :board, :player1, :player2, :gui

  def init_game(board)
    @board = Board.new(board)
    @player1 = AiPlayer.new('X', 10)
    @player2 = AiPlayer.new('O', -10)
    @gui = MockGui.new
  end

  def test_one_box_left_x_turn_cat
    init_game(['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X'])
    assert_equal false, @board.game_over?
    player1.play_turn(@board, @player2, @gui)
    assert_equal %w[X O X X O O O X X], @board.board
    assert_equal true, @board.game_over?
  end

  def test_two_boes_left_o_turn_cat
    init_game(['X', 'O', 'X', 3, 'O', 5, 'O', 'X', 'X'])
    assert_equal false, @board.game_over?
    player2.play_turn(@board, @player1, @gui)
    assert_equal ['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X'], @board.board
    assert_equal false, @board.game_over?
  end

  def test_takes_x_win
    init_game(['X', 1, 'X', 3, 'O', 5, 'O', 'X', 'X'])
    assert_equal false, @board.game_over?
    player1.play_turn(@board, @player2, @gui)
    assert_equal ['X', 'X', 'X', 3, 'O', 5, 'O', 'X', 'X'], @board.board
    assert_equal true, @board.game_over?
    assert_equal true, @board.is_win?
  end

  def test_takes_o_win
    init_game(['X', 1, 'X', 'O', 'O', 5, 'O', 'X', 'X'])
    assert_equal false, @board.game_over?
    player2.play_turn(@board, @player1, @gui)
    assert_equal ['X', 1, 'X', 'O', 'O', 'O', 'O', 'X', 'X'], @board.board
    assert_equal true, @board.game_over?
    assert_equal true, @board.is_win?
  end

  def test_takes_x_wont_lose
    init_game(['O', 1, 'O', 3, 'X', 5, 'X', 7, 8])
    assert_equal false, @board.game_over?
    player1.play_turn(@board, @player2, @gui)
    assert_equal ['O', 'X', 'O', 3, 'X', 5, 'X', 7, 8], @board.board
    assert_equal false, @board.is_win?
  end

  def test_takes_o_wont_lose
    init_game(['X', 1, 'X', 3, 'O', 5, 'O', 7, 8])
    assert_equal false, @board.game_over?
    player2.play_turn(@board, @player1, @gui)
    assert_equal ['X', 'O', 'X', 3, 'O', 5, 'O', 7, 8], @board.board
    assert_equal false, @board.is_win?
  end

end
