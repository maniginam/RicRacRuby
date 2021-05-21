# frozen_string_literal: true

require_relative '../lib/minimax'


class Helper
  attr_accessor :board, :player1, :player2

  def initialize(board)
    @board = Board.new(board)
    @player1 = MockPlayer.new(:mock, 'X', 10)
    @player2 = MockPlayer.new(:mock, 'O', -10)
  end

end

class MockPlayer < Player
  attr_accessor :kind, :token, :score, :box, :test_box

  def play_turn(board)
    if @test_box.nil?
      minimax = Minimax.new(board.board, @score)
      @box = minimax.choose_best_box
    else
      @box = @test_box
    end

    board.board[@box] = @token
  end
end
