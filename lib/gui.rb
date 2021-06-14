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

  def prompt_box_selection
    raise NotImplementedError, 'You must implement the prompt_box_selection method'
  end

  def prompt_box_taken
    raise NotImplementedError, 'You must implement the prompt_box_taken method'
  end

  def prompt_invalid_box
    raise NotImplementedError, 'You must implement the prompt_invalid_box method'
  end

  def show_win
    raise NotImplementedError, 'You must implement the show_win method'
  end

  def prompt_play_again
    raise NotImplementedError, 'You must implement the play_again method'
  end
end
