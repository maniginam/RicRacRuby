# frozen_string_literal: true

require_relative '../lib/minimax'

class AiPlayer < Player
  attr_accessor :kind, :token, :score

  def play_turn(board, opponent)
    minimax = Minimax.new(board.board, [self, opponent])
    box = minimax.choose_best_box(self)
    board.board[box] = @token
  end
end