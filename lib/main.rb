# frozen_string_literal: true

require_relative 'game_master'
require_relative 'board'
require_relative 'player'
require_relative 'terminal_gui'

# main
def main
  gui = Terminal.new
  gui.welcome
end
