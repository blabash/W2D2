class Piece
  attr_reader :pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def inspect
    'piece'
  end
end


class Rook < Piece
  def initialize(color, board, pos)
    super
  end

  def symbol
    if @color == :white
      return "♖"
    else
      return "♜"
    end
  end




end