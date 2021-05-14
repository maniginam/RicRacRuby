# frozen_string_literal: true

# minimax
class Minimax
  attr_accessor :best_box
  attr_reader :board
  attr_reader :score
  attr_reader :player

  def initialize(board, player)
    @board = board
    @player = player

  end

  def is_best_box?(score, box_score)
    @player == -10 && box_score < score || @player == 10 && box_score > score
  end

  def choose_best_box(board_scores)
    score = -@player
    box = 0
    while box < board_scores.size
      if board_scores[box].is_a?(Integer) && is_best_box?(score, board_scores[box])
        @best_box = box
        score = board_scores[box]
      end
      box += 1
    end
    @best_box
  end

  def get_box_scores(board)
    ['X', 'O', 'X', 0, 'O', 'O', 'O', 'X', 'X']
  end

end

