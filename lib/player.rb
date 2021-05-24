# frozen_string_literal: true

# Player
class Player
  attr_accessor :token, :score, :box

  def initialize(token, score)
    @token = token
    @score = score
  end

  def play_turn
    raise NotImplementedError, 'You must implement the play_turn method'
  end

end
