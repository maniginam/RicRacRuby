# frozen_string_literal: true

require_relative 'game_master'
require_relative 'board'
require_relative 'player'
require_relative 'terminal_gui'

# Tic-Tac-Ruby-o
class TicTacRubyO
  attr_accessor :gui, :setup, :board, :player1, :player2

  def initialize
    @gui = Terminal.new
  end
end



# main
def main

  gui.welcome
end
