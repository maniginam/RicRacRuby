# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game_master'
require_relative 'spec_helper'

# Test game_master
class GameMasterTest < Minitest::Test
  attr_accessor :board, :player1, :player2

  def init_game(board)
      @board = Board.new(board)
      @player1 = MockPlayer.new(:mock, 'X', 10)
      @player2 = MockPlayer.new(:mock, 'O', -10)
  end

  # Game is over: cat's game
  def test_game_over_cats_game
    init_game(%w[X O X X O O O X X])
    game_master = GameMaster.new(@board, [@player1, @player2])
    game_master.run_game
    assert_equal 0, game_master.winner
  end

  def test_game_over_x_wins
    init_game(%w[X O X O O X O X X])
    game_master = GameMaster.new(@board, [@player1, @player2])
    game_master.run_game
    assert_equal player1, game_master.winner
  end

  def test_game_over_o_wins
    init_game(['X', 'O', 'O', 'X', 'O', 5, 'O', 'X', 'X'])
    game_master = GameMaster.new(@board, [@player1, @player2])
    game_master.player = player2
    game_master.run_game
    assert_equal player2, game_master.winner
  end

  def test_one_box_left_x_turn
    init_game(['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X'])
    game_master = GameMaster.new(@board, [@player1, @player2])
    assert_nil game_master.winner
    game_master.run_game
    assert_equal %w[X O X X O O O X X], game_master.board.board
    assert_equal 0, game_master.winner
  end

  def test_o_turn
    init_game(['X', 'O', 'X', 3, 'O', 5, 'O', 'X', 'X'])
    game_master = GameMaster.new(@board, [@player1, @player2])
    game_master.player = player2
    assert_nil game_master.winner
    game_master.run_game
    assert_equal 0, game_master.winner
  end

  def test_x_turn
    init_game(['X', 'O', 2, 3, 'O', 5, 'O', 'X', 'X'])
    game_master = GameMaster.new(@board, [@player1, @player2])
    assert_nil game_master.winner
    game_master.run_game
    assert_equal 0, game_master.winner
  end
end