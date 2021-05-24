# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# GameMaster
class GameMaster
  attr_accessor :board, :player1, :player2, :player, :winner

  def initialize(board, players)
    @board = board
    @player1 = players[0]
    @player2 = players[1]
    @player = @player1
    @winner = nil
  end

  def allow_turn
    until board.game_over?
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
