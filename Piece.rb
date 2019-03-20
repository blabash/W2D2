require "byebug"
require 'singleton'

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
  
  attr_reader :color, :symbol

  def initialize
    @color = :nil
    @symbol = "   "
  end

end


module Slideable

  def horizontal_dirs(pos)
    up = []
    down = []
    left = []
    right = []

    i = 1
    while pos[1] + i <= 7
      next_pos = @board.grid[ pos[0] ][pos[1] +i] 
      next_index = [pos[0], pos[1] + i]
      arr = up

      if next_pos.is_a?(NullPiece)
        arr << next_index
        i += 1 
      elsif next_pos.color == self.color
        break
      else 
        arr << next_index
        break
      end
    end

    i = 1
    while pos[1] - i >= 0

      next_pos = @board.grid[ pos[0] ][pos[1] -i] 
      next_index = [pos[0], pos[1] - i]
      arr = down

      if next_pos.is_a?(NullPiece)
        arr << next_index
        i += 1 
      elsif next_pos.color == self.color
        break
      else 
        arr << next_index
        break
      end

    end

    i = 1
    while pos[0] + i <= 7

      next_pos = @board.grid[pos[0] + i][pos[1]] 
      next_index = [pos[0] + i, pos[1]]
      arr = right

      if next_pos.is_a?(NullPiece)
        arr << next_index
        i += 1 
      elsif next_pos.color == self.color
        break
      else 
        arr << next_index
        break
      end
    end

    i = 1
    while pos[0] - i >= 0

      next_pos = @board.grid[pos[0] - i][pos[1]] 
      next_index = [pos[0] - i, pos[1]]
      arr = left

      if next_pos.is_a?(NullPiece)
        arr << next_index
        i += 1 
      elsif next_pos.color == self.color
        break
      else 
        arr << next_index
        break
      end

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
      next_pos = @board.grid[pos[0] + i][pos[1] + i]
      next_index = [pos[0] + i, pos[1] + i]
      arr = potential_moves_up_right

      if next_pos.is_a?(NullPiece)
        arr << next_index
        i += 1
      elsif next_pos.color == self.color
        break
      else
        arr << next_index
        break
      end
    end

    i = 1
    while pos[0] - i >= 0 && pos[1] - i >= 0
      next_pos = @board.grid[pos[0] - i][pos[1] - i]
      next_index = [pos[0] - i, pos[1] - i]
      arr = potential_moves_down_left

      if next_pos.is_a?(NullPiece)
        arr << next_index
        i += 1
      elsif next_pos.color == self.color
        break
      else
        arr << next_index
        break
      end
    end

    i = 1
    while pos[0] + i <= 7 && pos[1] - i >= 0
      next_pos = @board.grid[pos[0] + i][pos[1] - i]
      next_index = [pos[0] + i, pos[1] - i]
      arr = potential_moves_down_right

      if next_pos.is_a?(NullPiece)
        arr << next_index
        i += 1
      elsif next_pos.color == self.color
        break
      else
        arr << next_index
        break
      end
    end

    i = 1
    while pos[0] - i >= 0 && pos[1] + i <= 7
      next_pos = @board.grid[pos[0] - i][pos[1] + i]
      next_index = [pos[0] - i, pos[1] + i]
      arr = potential_moves_up_left

      if next_pos.is_a?(NullPiece)
        arr << next_index
        i += 1
      elsif next_pos.color == self.color
        break
      else
        arr << next_index
        break
      end
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
