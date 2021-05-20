# frozen_string_literal: true

require_relative '../lib/minimax'

class MockPlayer < Player
  attr_accessor :kind, :token, :score, :box

  def play_turn(board)
    if @box.nil?
      minimax = Minimax.new(board.board, @score)
      scores = minimax.score_boxes
      @box = minimax.choose_best_box(scores)
    else
      board.board[@box] = @token
    end
  end
end
