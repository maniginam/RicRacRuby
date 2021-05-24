# frozen_string_literal: true

require_relative '../lib/minimax'
require_relative '../lib/gui'


class MockPlayer < Player
  attr_accessor :gui, :token, :score, :box, :test_box

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

class MockGui < Gui
  attr_accessor :num_of_humans, :human

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
end
