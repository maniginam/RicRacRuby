require 'minitest/autorun'
require_relative '../lib/human_player'
require_relative '../lib/board'
require_relative 'spec_helper'

class HumanPlayerTest < Minitest::Test
  attr_accessor :board, :player1, :player2, :gui

  def init_game(board)
    @board = Board.new(board)
    @player1 = HumanPlayer.new('X', 10)
    @player2 = HumanPlayer.new('O', -10)
    @gui = MockGui.new
  end

  def test_play_turn
    @gui = MiniTest::Mock.new
    @gui.expect(:show_turn, nil, [nil])
    @gui.expect(:play_turn, nil, [nil])
  end
end
