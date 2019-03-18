require_relative 'piece.rb'
require 

class Board
  attr_reader :board
  def initialize
    @board = Array.new(8) {Array.new(8)}
    (0...board.length).each do |i|
      (0...board.length).each do |j|
        if i == 0 || i == 1 || i == 6 || i == 7
          board[i][j] = Piece.new([i,j])
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    if !( (0..7) === start_pos[0] &&  (0..7) === start_pos[1] )
      raise "start position out of bounds, dude!"
    end

    if board[start_pos[0]][start_pos[1]] == nil
      raise "no piece there, bro!"
    end


    if !( (0..7) === end_pos[0] &&  (0..7) === end_pos[1] )
      raise "position out of bounds, guy!"
    end

    board[end_pos[0]][end_pos[1]] = board[start_pos[0]][start_pos[1]]

    board[start_pos[0]][start_pos[1]] = nil
  end

end