# frozen_string_literal: true

require_relative '../lib/minimax'


class MockPlayer < Player
  attr_accessor :kind, :token, :score, :box, :test_box

  def play_turn(board, opponent)
    if @test_box.nil?
      minimax = Minimax.new(board.board, [self, opponent])
      @box = minimax.choose_best_box(self)
    else
      @box = @test_box
    end
    board.board[@box] = @token
  end
end
