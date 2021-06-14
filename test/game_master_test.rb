require 'minitest/autorun'
require_relative 'spec_helper'
require_relative '../lib/game_master'
require_relative '../lib/gui'

class GameMasterTest < Minitest::Test
  attr_accessor :game_master, :board, :player1, :player2, :gui

  def init_game(board)
    @board = Board.new(board)
    @gui = MockGui.new
    @player1 = MockPlayer.new('X', 10)
    @player2 = MockPlayer.new('O', -10)
    @game_master = GameMaster.new(gui, @board, [@player1, @player2])
  end

  def test_game_over_cats_game
    init_game(%w[X O X X O O O X X])
    @gui = MiniTest::Mock.new
    @game_master.run_game
    gui.expect(:draw_board, nil, [@board.board])
    gui.expect(:show_win, nil, [@board.board, nil])
    assert_nil @game_master.winner
  end

  def test_game_over_x_wins
    init_game(%w[X O X O O X O X X])
    gui = MiniTest::Mock.new
    @game_master.run_game
    gui.expect(:draw_board, nil, [@board.board])
    gui.expect(:show_win, nil, [@board.board, @player1])
    assert_equal @player1, @game_master.winner
  end

  def test_game_over_o_wins
    init_game(['X', 'O', 'O', 'X', 'O', 5, 'O', 'X', 'X'])
    @game_master.player = player2
    gui = MiniTest::Mock.new
    @game_master.run_game
    gui.expect(:draw_board, nil, [@board.board])
    gui.expect(:show_win, nil, [@board.board, @player2])
    assert_equal @player2, @game_master.winner
  end

  def test_one_box_left_x_turn
    init_game(['X', 'O', 'X', 3, 'O', 'O', 'O', 'X', 'X'])
    assert_nil @game_master.winner
    @game_master.run_game
    assert_equal %w[X O X X O O O X X], @game_master.board.board
    assert_nil @game_master.winner
  end

  def test_o_turn
    init_game(['X', 'O', 'X', 3, 'O', 5, 'O', 'X', 'X'])
    @game_master.player = @player2
    assert_nil @game_master.winner
    @game_master.run_game
    assert_nil @game_master.winner
  end

  def test_x_turn
    init_game(['X', 'O', 2, 3, 'O', 5, 'O', 'X', 'X'])
    assert_nil @game_master.winner
    @game_master.run_game
    assert_nil @game_master.winner
  end

  def test_play_again_yes
    init_game(['blah'])
    gui.stub :prompt_play_again, 'Y' do
      assert @game_master.play_again
    end
  end
end

