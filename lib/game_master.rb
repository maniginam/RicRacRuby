# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# GameMaster
class GameMaster
  attr_accessor :gui, :board, :player1, :player2, :player, :winner

  def initialize(gui, board, players)
    @gui = gui
    @board = board
    @player1 = players[0]
    @player2 = players[1]
    @player = @player1
    @winner = nil
  end

  def run_game
    @gui.draw_board(@board.board)
    until board.game_over?
      @player.play_turn(@board, next_player, @gui)
    end
    @winner = get_winner
    @gui.show_winner(@winner)
  end

  private

  def get_winner
    if @board.is_win?
      @player
    end
  end

  def next_player
    @player = if @player == @player1
                @player2
              else
                @player1
              end
  end
end
