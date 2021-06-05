# frozen_string_literal: true

require_relative 'minimax'
# Ai Player
class AiPlayer < Player
  attr_accessor :token, :score, :box

  def play_turn(board, opponent, gui)
    gui.show_turn(self, board.board)
    self_map = { token: self.token, score: self.score }
    minimax = Minimax.new(board.board, [self_map, { token: opponent.token, score: opponent.score }])
    @box = minimax.choose_best_box(self_map)
    board.board[box] = @token
  end
end
