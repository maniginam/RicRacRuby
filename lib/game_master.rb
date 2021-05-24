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
    until board.game_over?
      @gui.draw_board(@board.board)
      @player.play_turn(@board, next_player)
    end
    @winner = get_winner
  end

  private

  def get_winner
    if @board.is_win?
      @player
    else
      0
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
