# frozen_string_literal: true

# Game Gui
class Gui
  attr_accessor :num_of_humans, :human, :board

  def welcome
    raise NotImplementedError, 'You must implement the welcome method'
  end

  def prompt_player_count
    raise NotImplementedError, 'You must implement the prompt_player_count method'
  end

  def prompt_player_selection
    raise NotImplementedError, 'You must implement the prompt_player_selection method'
  end

  def draw_board
    raise NotImplementedError, 'You must implement the draw_board method'
  end

  def show_turn
    raise NotImplementedError, 'You must implement the show_turn method'
  end

  def show_winner
    raise NotImplementedError, 'You must implement the show_winner method'
  end
end
