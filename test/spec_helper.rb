# frozen_string_literal: true

class MockPlayer < Player
  attr_accessor :kind, :token, :score, :box

  def play_turn(board)
    board.board[@box] = @token
  end
end
