# frozen_string_literal: true

require_relative 'minimax'
# Ai Player
class HumanPlayer < Player
  attr_accessor :token, :score

  def play_turn(board, opponent)
    board.board[box] = @token
  end
end

