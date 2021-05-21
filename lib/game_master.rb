# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# GameMaster
class GameMaster
  attr_accessor :board, :players, :player, :winner

  def initialize(board, players)
    @board = board
    @players = players
    @player = @players[0]
    @winner = nil
  end

  def run_game
    until board.game_over?
      @player.play_turn(@board)
      @player = next_player
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
    @player = if @player == @players[0]
                @players[1]
              else
                @players[0]
              end
  end
end
