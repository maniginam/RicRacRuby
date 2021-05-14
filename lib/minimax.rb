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
    @score = -player
  end

  def choose_best_box(board_scores)
    box = 0
    while box < board_scores.size
      if board_scores[box].is_a?(Integer)
        if @player == -10 && board_scores[box] < @score
          @best_box = box
          @score = board_scores[box]
        elsif @player == 10 && board_scores[box] > @score
          @best_box = box
          @score = board_scores[box]
        end
      end
      box += 1
    end
    @best_box
  end

  # def get_box_scores(board)
  #   player = -@player
  #   trial_board = board
  #   box = 0
  #   while box > board.size
  #     if board[box].is_a?(Integer)
  #
  #     end
  #   end
  # end


end

