require_relative 'minimax'

class HumanPlayer < Player
  attr_accessor :token, :score, :box

  def play_turn(board, opponent, gui)
    gui.show_turn(self, board.board)
    @box = gui.prompt_box_selection
    until board.box_available(@box)
      gui.prompt_invalid_box
      gui.show_turn(self, board.board)
      @box = gui.prompt_box_selection
    end
  end
end



