require 'minitest/autorun'
require_relative '../lib/setup'
require_relative 'spec_helper'

class SetupTest < Minitest::Test
  attr_accessor :gui, :setup

  def init
    @gui = MockGui.new
    @setup = Setup.new(gui, %w[X O])
  end

  def test_set_num_of_humans
    init
    @gui.num_of_humans = 0
    @setup.set_num_of_humans
    assert_equal 0, @setup.num_of_humans
    @gui.num_of_humans = 1
    @setup.set_num_of_humans
    assert_equal 1, @setup.num_of_humans
    @gui.num_of_humans = 2
    @setup.set_num_of_humans
    assert_equal 2, @setup.num_of_humans
  end

  def test_set_players
    init
    @setup.num_of_humans = 0
    @setup.set_players
    assert_equal true, @setup.player1.is_a?(AiPlayer)
    assert_equal true, @setup.player2.is_a?(AiPlayer)

    @setup.num_of_humans = 2
    @setup.set_players
    assert_equal true, @setup.player1.is_a?(HumanPlayer)
    assert_equal true, @setup.player2.is_a?(HumanPlayer)
    @setup.num_of_humans = 1
    @gui.human = 'X'
    @setup.set_players
    assert_equal true, @setup.player1.is_a?(HumanPlayer)
    assert_equal true, @setup.player2.is_a?(AiPlayer)

    @setup.num_of_humans = 1
    @gui.human = 'O'
    @setup.set_players
    assert_equal true, @setup.player1.is_a?(AiPlayer)
    assert_equal true, @setup.player2.is_a?(HumanPlayer)
  end

end

