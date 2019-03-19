require_relative 'piece.rb'


class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
    (0...grid.length).each do |i|
      (0...grid.length).each do |j|
        if i == 0 || i == 1 || i == 6 || i == 7
          grid[i][j] = Piece.new([i,j])
        end
      end
    end
  end

  def [] (pos)
    @grid[pos[0]][pos[1]]
  end

  def []= (pos, value)
    @grid[pos[0]][pos[1]] = value
  end



  def move_piece(start_pos, end_pos)
    if !valid_pos?(start_pos)
      raise "start position out of bounds, dude!"
    end

    if grid[start_pos] == nil
      raise "no piece there, bro!"
    end


    if !valid_pos?(end_pos)
      raise "position out of bounds, guy!"
    end

    grid[end_pos] = grid[start_pos]

    grid[start_pos] = nil
  end

  def valid_pos?(pos)
    return false if !( (0..7) === pos[0] &&  (0..7) === pos[1] )
    true
  end




end