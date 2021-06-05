# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# GameMaster
class GameMaster
  attr_accessor :gui, :board, :player1, :player2, :player, :winner, :play_again

  def initialize(gui, board, players)
    @gui = gui
    @board = board
    @player1 = players[0]
    @player2 = players[1]
    @player = @player1
    @winner = nil
  end

  def play_again
    if @gui.prompt_play_again == 'Y'
      @play_again = true
    end
  end

  def run_game
    @gui.draw_board(@board.board)
    until board.game_over?
      @player.play_turn(@board, next_player, @gui)
      @board.board[@player.box] = @player.token
      @player = next_player unless board.game_over?
    end
    get_winner
    @gui.show_win(@board.board, @winner)
  end

  private

  def get_winner
    @winner = @player if @board.is_win?
  end

  def next_player
    if @player == @player1
      @player2
    else
      @player1
    end
  end
end
