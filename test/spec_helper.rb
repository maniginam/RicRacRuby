require_relative '../lib/minimax'
require_relative '../lib/gui'

class MockPlayer < Player
  attr_accessor :gui, :token, :score, :box, :test_box

  def play_turn(board, opponent, gui)
    if @test_box.nil?
      self_map = { token: self.token, score: self.score }
      minimax = Minimax.new(board.board, [self_map, { token: opponent.token, score: opponent.score }])
      @box = minimax.choose_best_box(self_map)
    else
      @box = @test_box
    end
    board.board[@box] = @token
  end
end

class MockGui < Gui
  attr_accessor :num_of_humans, :human, :board, :box

  def welcome
    nil
  end

  def prompt_player_count
    @num_of_humans
  end

  def prompt_player_selection(_)
    @human
  end

  def draw_board(_)
    nil
  end

  def show_turn(_, _)
    nil
  end

  def prompt_box_selection
    @box
  end

  def prompt_box_taken(box)
    @box += 1
  end

  def show_win(_, _)
    nil
  end
end
