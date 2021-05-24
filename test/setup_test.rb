# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/setup'
require_relative 'spec_helper'

# Test Gui
class SetupTest < Minitest::Test

  def test_set_num_of_humans
    gui = MockGui.new
    setup = Setup.new(gui, %w[X O])
    gui.num_of_humans = 0
    setup.set_num_of_humans
    assert_equal 0, setup.num_of_humans
    gui.num_of_humans = 1
    setup.set_num_of_humans
    assert_equal 1, setup.num_of_humans
    gui.num_of_humans = 2
    setup.set_num_of_humans
    assert_equal 2, setup.num_of_humans
  end

  def test_set_players
    gui = MockGui.new
    setup = Setup.new(gui, %w[X O])
    setup.num_of_humans = 0
    setup.set_players
    assert_equal true, setup.player1.is_a?(AiPlayer)
    assert_equal true, setup.player2.is_a?(AiPlayer)

    setup.num_of_humans = 2
    setup.set_players
    assert_equal true, setup.player1.is_a?(HumanPlayer)
    assert_equal true, setup.player2.is_a?(HumanPlayer)

    setup.num_of_humans = 1
    gui.human = 1
    setup.set_players
    assert_equal true, setup.player1.is_a?(HumanPlayer)
    assert_equal true, setup.player2.is_a?(AiPlayer)

    setup.num_of_humans = 1
    gui.human = 2
    setup.set_players
    assert_equal true, setup.player1.is_a?(AiPlayer)
    assert_equal true, setup.player2.is_a?(HumanPlayer)
  end

  # def test_num_of_players
  #   setup = Gui.new
  #   out = capture_io do
  #     setup.prompt_player_count
  #   end
  #   assert_equal "How many humans will be playing?\n", out[0]
  # end
  #
  # def test_no_humans
  #   setup = Gui.new
  #   setup.num_of_humans = 0
  #   out = capture_io do
  #     setup.maybe_select_player
  #   end
  #   assert_equal "Ok.  I will play for yet another cat's game against myself...\n", out[0]
  # end
  #
  # def test_2_humans
  #   setup = Gui.new
  #   setup.num_of_humans = 2
  #   out = capture_io do
  #     setup.maybe_select_player
  #   end
  #   assert_equal "May the odds be eva' in your favor!\n", out[0]
  # end
  #
  # def test_player_human_x
  #   setup = Gui.new
  #   setup.num_of_humans = 1
  #   out = capture_io do
  #     setup.maybe_select_player
  #   end
  #   assert_equal "A challenger! Do you want to be X or O?\n", out[0]
  # end
end

