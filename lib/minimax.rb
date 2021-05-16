# frozen_string_literal: true

require_relative '../lib/board'

# minimax
class Minimax
  attr_accessor :best_box, :board_scores, :temp_board
  attr_reader :board, :score, :player

  def initialize(board, player)
    @board = board
    @player = player
    @board_scores = []
  end

  def is_best_box?(player, score, box_score)
    player == -10 && box_score < score || player == 10 && box_score > score
  end

  def is_best_opponent_box?(player, score, box_score)
    player == -10 && box_score > score || player == 10 && box_score < score
  end

  def choose_best_box(board_scores)
    score = -@player
    box = 0
    while box < board_scores.size
      if board_scores[box].is_a?(Integer) && is_best_box?(@player, score, board_scores[box])
        score = board_scores[box]
        best_box = box
      end
      box += 1
    end
    best_box
  end

  def calculate_score(board, player, depth)
    if board.is_win?
      if player == 10
        score = player - depth
      else
        score = player + depth
      end
    else
      score = 0
    end
    score
  end

  def score_box(board, player, depth)
    if board.game_over?
      score = calculate_score(board, player, depth)
    else
      score = player
      player = -player
      board.board.each do |box|
        if box.is_a?(Integer)
          if player == 10
            board.board[box] = 'X'
          else
            board.board[box] = 'O'
          end
          box_score = score_box(Board.new(board.board), player, depth + 1)
          if is_best_box?(player, score, box_score)
            score = box_score
          end
          board.board[box] = box
        end
      end
    end
    score
  end

  def score_boxes
    player = @player
    @board.each do |box|
      if box.is_a?(Integer)
        if player == 10
          @board[box] = 'X'
        else
          @board[box] = 'O'
        end
        box_score = score_box(Board.new(@board), player, 0)
        @board[box] = box
      else
        box_score = box
      end
      @board_scores.append(box_score)
    end
    @board_scores
  end

end

