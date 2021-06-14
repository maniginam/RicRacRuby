require 'minitest/autorun'
require_relative '../lib/terminal_gui'
require_relative '../lib/gui'
require_relative '../lib/human_player'
require_relative '../lib/ai_player'

class TerminalTest < Minitest::Test
  attr_accessor :terminal

  def initialize(name)
    super
    @terminal = Terminal.new
  end

  def test_welcome
    out = capture_io do
      terminal.welcome
    end
    assert_equal "Welcome to Tic-Tac-Ruby-o\n", out[0]
  end

  def test_num_of_players
    terminal.stub :gets, '0' do
      terminal.num_of_humans = '0'
      out = capture_io do
        terminal.prompt_player_count
      end
      assert_equal "How many humans will be playing?\n", out[0]
    end
  end

  def test_player_count_response
    terminal.num_of_humans = 0
    assert_equal "Ok.  I will play for yet another cat's game against myself...", terminal.player_count_response

    terminal.num_of_humans = 2
    assert_equal 'May the best player win!', terminal.player_count_response

    terminal.num_of_humans = 1
    assert_equal "May the odds be eva' in your favor!", terminal.player_count_response
  end

  def test_player_selection
    tokens = %w[CHASE RUBBLE]
    @terminal.num_of_humans = 1
    terminal.stub :gets, 'CHASE' do
      terminal.stub :set_human, nil do
        out = capture_io do
          terminal.prompt_player_selection(tokens)
        end
        assert_equal "Do you want to be CHASE or RUBBLE?\n", out[0]
      end
    end

    out = capture_io do
      terminal.set_human(tokens, 'CHASE')
    end
    assert_equal 'CHASE', terminal.human
    assert_equal "Alright, I'll be RUBBLE\n", out[0]

    out = capture_io do
      terminal.set_human(tokens, 'RUBBLE')
    end
    assert_equal 'RUBBLE', terminal.human
    assert_equal "Alright, I'll be CHASE\n", out[0]

    out = capture_io do
      terminal.set_human(tokens, 'ROCKY')
    end
    assert_equal 'RUBBLE', terminal.human
    assert_equal "That wasn't an option, so I'll be CHASE and you can be RUBBLE!\n", out[0]
  end

  def test_draw_board_cat
    board = terminal.draw_board(%w[X O X X O O O X X])
    assert_equal String("  X | O | X  \n ----------- \n  X | O | O \n ----------- \n  O | X | X \n"), board
  end

  def test_draw_board_empty
    board = terminal.draw_board([0, 1, 2, 3, 4, 5, 6, 7, 8])
    assert_equal String("  0 | 1 | 2  \n ----------- \n  3 | 4 | 5 \n ----------- \n  6 | 7 | 8 \n"), board
  end

  def test_player_turn_ai
    player = AiPlayer.new('X', 10)
    opponent = HumanPlayer.new('O', -10)
    board = Board.new([0, 1, 2, 3, 4, 5, 6, 7, 8])
    out = capture_io do
      player.play_turn(board, opponent, terminal)
    end
    assert_equal String("  0 | 1 | 2  \n ----------- \n  3 | 4 | 5 \n ----------- \n  6 | 7 | 8 \nX's Turn!\n"),
                 out[0]
  end

  def test_player_turn_human
    player = HumanPlayer.new('O', -10)
    opponent = AiPlayer.new('X', 10)
    board = Board.new([0, 1, 2, 3, 4, 5, 6, 7, 8])
    terminal.stub :gets, '0' do
      out = capture_io do
        player.play_turn(board, opponent, terminal)
      end
      assert_equal String("  0 | 1 | 2  \n ----------- \n  3 | 4 | 5 \n ----------- \n  6 | 7 | 8 \nO's Turn!\nSelect a box\n"),
                   out[0]
    end
  end

  def test_show_winner_cat
    terminal.stub :draw_board, nil do
      out = capture_io do
        terminal.show_win('blah', nil)
      end
      assert_equal String("\nCat's Game\n\n"), out[0]
    end
  end

  def test_show_winner_x
    player1 = HumanPlayer.new('X', 10)
    terminal.stub :draw_board, nil do
      out = capture_io do
        terminal.show_win('blah', player1)
      end
      assert_equal String("\nX Wins!\n\n"), out[0]
    end
  end

  def test_show_winner_o
    player2 = AiPlayer.new('O', -10)
    terminal.stub :draw_board, nil do
      out = capture_io do
        terminal.show_win('blah', player2)
      end
      assert_equal String("\nO Wins!\n\n"), out[0]
    end
  end

  def test_box_taken
    @player2 = HumanPlayer.new('O', -10)
    terminal.stub :prompt_box_selection, 3 do
      out = capture_io do
        terminal.prompt_box_taken(3)
      end
      assert_equal String("Box 3 is taken\n"), out[0]
    end
  end

  def test_non_valid_box_selection
    Board.new([0, 1, 2, 3, 'X', 5, 6, 7, 8])
    assert_equal false, terminal.valid_box?('hello world')
    assert_equal false, terminal.valid_box?('h')
    assert_equal true, terminal.valid_box?('1')
    assert_equal true, terminal.valid_box?('0')
    assert_equal false, terminal.valid_box?('9')
    assert_equal false, terminal.valid_box?('1000')
  end

  def test_play_again
    terminal.stub :gets, "y", "y" do
      out = capture_io do
        terminal.prompt_play_again
      end
      assert_equal String("Do you want to play again?\n"), out[0]
    end
  end
end
