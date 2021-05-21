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

  def score_boxes(board, player, depth)
    score = -player
    if board.game_over?
      score = calculate_score(board, player, depth)
    else
      (0...board.board.size).each do |box|
        score = -player
        if board.board[box].is_a?(Integer)
          temp_board = Board.new(board.board)
          temp_board.board[box] = get_player_token(player)
          box_score = score_box(temp_board, player, depth)
          if is_best_box?(player, score, box_score)
            score = box_score
            @board_scores[box] = score
          end
          temp_board.board[box] = box
          else @board_scores[box] = board.board[box]
        end
      end
    end
    score
  end

  def choose_best_box
    best_box = nil
    current_score = -@player
    score_boxes(Board.new(@board), @player, 0)
    (0...@board.size).each do |box|
      next unless @board_scores[box].is_a?(Integer)

      if is_best_box?(@player, current_score, @board_scores[box])
        current_score = @board_scores[box]
        best_box = box
      end
    end
    best_box
  end

  private

  def score_each_box(board, depth, player)
    score = player
    player = -player
    board.board.each do |box|
      next unless box.is_a?(Integer)

      board.board[box] = get_player_token(player)
      box_score = score_box(Board.new(board.board), player, depth + 1)
      score = box_score if is_best_box?(player, score, box_score)
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
