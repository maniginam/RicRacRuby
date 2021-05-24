# frozen_string_literal: true

require_relative 'minimax'
# Ai Player
class AiPlayer < Player
  attr_accessor :token, :score

  def play_turn(board, opponent)
    minimax = Minimax.new(board.board, [self, opponent])
    box = minimax.choose_best_box(self)
    board.board[box] = @token
  end
end
