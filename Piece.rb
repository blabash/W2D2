require "byebug"
class Piece
  attr_accessor :pos
  attr_reader :color
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  # def inspect
  #   'piece'
  # end
end

class NullPiece
  include Singleton
  

end


module Slideable

  def horizontal_dirs(pos)
    up = []
    down = []
    left = []
    right = []

    i = 1
    while pos[1] + i <= 7
      up << [pos[0],pos[1] + i]
      i += 1 
      
    end

    i = 1
    while pos[1] - i >= 0
      down << [pos[0],pos[1] - i]
      i += 1 
    end

    i = 1
    while pos[0] + i <= 7
      right << [pos[0] + i,pos[1]]
      i += 1 
    end

    i = 1
    while pos[0] - i >= 0
      left << [pos[0] - i,pos[1]]
      i += 1 
    end

    left + right + up + down

  end

  def diagonal_dirs(pos)
    potential_moves_up_right = []
    potential_moves_down_left = []
    potential_moves_down_right = []
    potential_moves_up_left = []


    i = 1
    while pos[0] + i <= 7 && pos[1] + i <= 7

      potential_moves_up_right << [pos[0] + i, pos[1] +i]
      i += 1
    end

    i = 1
    while pos[0] - i >= 0 && pos[1] - i >= 0
      potential_moves_down_left << [pos[0] - i, pos[1] -i]
      i += 1
    end

    i = 1
    while pos[0] + i <= 7 && pos[1] - i >= 0
      potential_moves_down_right << [pos[0] + i, pos[1] -i]
      i += 1
    end

    i = 1
    while pos[0] - i >= 0 && pos[1] + i <= 7
      potential_moves_up_left << [pos[0] - i, pos[1] +i]
      i += 1
    end

    potential_moves_up_right + potential_moves_down_left + potential_moves_down_right + potential_moves_up_left
  end

  def move(new_pos)
    move_directions = self.move_dirs
    moves = []

    if move_directions == "vertical"
      moves += horizontal_dirs(self.pos)
    elsif move_directions == "diagonal"
      moves += diagonal_dirs(self.pos)
    elsif move_directions == "both"
      moves += horizontal_dirs(self.pos)
      moves += diagonal_dirs(self.pos)
    end

    if moves.include?(new_pos)
      @board.move_piece(self.pos, new_pos)
      self.pos = new_pos
    else
      return nil 
    end


    moves
  end
end


class Bishop < Piece

  include Slideable

  def initialize(color, board, pos)
    super
  end

  def symbol
    if @color == :white
      return " ♗ "
    else
      return " ♝ "
    end
  end

  def move_dirs
    "diagonal"
  end
end


class Queen < Piece
  include Slideable

  def initialize(color, board, pos)
    super
  end

  def symbol
    if @color == :white
      return " ♕ "
    else
      return " ♛ "
    end
  end

  def move_dirs
    "both"
  end
end






class Rook < Piece
  include Slideable

  def initialize(color, board, pos)
    super
  end

  def symbol
    if @color == :white
      return " ♖ "
    else
      return " ♜ "
    end
  end

  def move_dirs
    "vertical"
  end
end
