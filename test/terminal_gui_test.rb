# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/terminal_gui'
# Test Terminal Gui
class TerminalTest < Minitest::Test
  def test_welcome
    terminal = Terminal.new
    out = capture_io do
      terminal.welcome
    end
    assert_equal ["Welcome to Tic-Tac-Ruby-o\n", ''], out
  end
end
