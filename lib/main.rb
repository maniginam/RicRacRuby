#!/usr/local/opt/ruby/bin ruby
# frozen_string_literal: true

# # frozen_string_literal: true

require_relative 'board'
require_relative 'game_master'
require_relative 'gui'
require_relative 'player'
require_relative 'ai_player'
require_relative 'human_player'
require_relative 'setup'
require_relative 'terminal_gui'

# Tic-Tac-Ruby-o
def main
  gui = Terminal.new
  setup = Setup.new(gui, %w[X O])
  gui.welcome
  setup.setup_game
  game = GameMaster.new(gui, setup.board, [setup.player1, setup.player2])
  game.run_game
end
