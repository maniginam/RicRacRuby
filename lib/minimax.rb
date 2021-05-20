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
    if !board.is_win?
      0
    elsif player == 10
      player - depth
    else
      player + depth
    end
  end

  def score_box(board, player, depth)
    if board.game_over?
      calculate_score(board, player, depth)
    else
      score_each_box(board, depth, player)
    end

  end

  def score_boxes
    player = @player
    @board.each do |box|
      if box.is_a?(Integer)
        maybe_win = Board.new(@board)
        @board[box] = get_player_token(player)
        if maybe_win.is_win?
          box_score = 10
        else
          box_score = score_box(Board.new(@board), player, 0)
          @board[box] = box
        end
      else
        box_score = box
      end
      @board_scores.append(box_score)
    end
    @board_scores
  end

  private

  def score_each_box(board, depth, player)
    score = player
    player = -player
    board.board.each do |box|
      next unless box.is_a?(Integer)

      board.board[box] = get_player_token(player)
      box_score = score_box(Board.new(board.board), player, depth + 1)
      if is_best_box?(player, score, box_score)
        score = box_score
      end
      board.board[box] = box
    end
    score
  end

  def get_player_token(player)
    if player == 10
      'X'
    else
      'O'
    end
  end

end

