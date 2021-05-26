# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/terminal_gui'
require_relative '../lib/gui'
require_relative '../lib/human_player'
require_relative '../lib/ai_player'

# Test Terminal Gui
class TerminalTest < Minitest::Test
  def test_welcome
    terminal = Terminal.new
    out = capture_io do
      terminal.welcome
    end
    assert_equal "Welcome to Tic-Tac-Ruby-o\n", out[0]
  end

  def test_num_of_players
    terminal = Terminal.new
    terminal.stub :gets, '0' do
      terminal.num_of_humans = '0'
      out = capture_io do
        terminal.prompt_player_count
      end
      assert_equal "How many humans will be playing?\n", out[0]
    end
  end

  def test_player_count_response
    terminal = Terminal.new
    terminal.num_of_humans = 0
    assert_equal "Ok.  I will play for yet another cat's game against myself...", terminal.player_count_response

    terminal.num_of_humans = 2
    assert_equal 'May the best player win!', terminal.player_count_response

    terminal.num_of_humans = 1
    assert_equal "May the odds be eva' in your favor!", terminal.player_count_response
  end

  def test_player_selection
    tokens = %w[CHASE RUBBLE]
    terminal = Terminal.new
    terminal.stub :gets, 'CHASE' do
      terminal.stub :set_human, nil do
        out = capture_io do
          terminal.prompt_player_selection(tokens)
        end
        assert_equal "Do you want to be CHASE or RUBBLE?\n", out[0]
      end
    end

    out = capture_io do
      terminal.set_human(tokens, "CHASE")
    end
    assert_equal "CHASE", terminal.human
    assert_equal "Alright, I'll be RUBBLE\n", out[0]

    out = capture_io do
      terminal.set_human(tokens, "RUBBLE")
    end
    assert_equal "RUBBLE", terminal.human
    assert_equal "Alright, I'll be CHASE\n", out[0]

    out = capture_io do
      terminal.set_human(tokens, "ROCKY")
    end
    assert_equal 'RUBBLE', terminal.human
    assert_equal "That wasn't an option, so I'll be CHASE and you can be RUBBLE!\n", out[0]
  end

  private

  def method_name(terminal)
    terminal.prompt_player_count
  end

end
