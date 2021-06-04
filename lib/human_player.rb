# frozen_string_literal: true

require_relative 'minimax'
# Ai Player
class HumanPlayer < Player
  attr_accessor :token, :score, :box

  def play_turn(board, opponent, gui)
    gui.show_turn(self, board.board)
    @box = gui.prompt_box_selection
    board.board[@box] = @token
  end
end

