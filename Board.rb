require_relative 'piece.rb'


class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
    (0...grid.length).each do |i|
      (0...grid.length).each do |j|
         if i == 0 && (j == 0 || j == 7) 
           grid[i][j] = Rook.new(:black, self, [i, j])

          elsif i == 7 && (j == 0 || j == 7) 
            grid[i][j] = Rook.new(:white, self, [i, j])

          elsif i == 0 && (j == 1 || j == 6) 
            grid[i][j] = Knight.new(:black, self, [i, j])

          elsif i == 7 && (j == 1 || j == 6) 
            grid[i][j] = Knight.new(:white, self, [i, j])

          elsif i == 0 && (j == 2 || j == 5) 
            grid[i][j] = Bishop.new(:black, self, [i, j])
          elsif i == 7 && (j == 2 || j == 5) 
            grid[i][j] = Bishop.new(:white, self, [i, j])
          elsif i == 0 && j == 3
            grid[i][j] = Queen.new(:black, self, [i, j])
          elsif i == 7 && j == 3
            grid[i][j] = Queen.new(:white, self, [i, j])
          elsif i == 0 && j == 4
            grid[i][j] = King.new(:black, self, [i, j])
          elsif i == 7 && j == 4
            grid[i][j] = King.new(:white, self, [i, j])
          elsif i == 1
            grid[i][j] = Pawn.new(:black, self, [i, j])
          elsif i == 6 
            grid[i][j] = Pawn.new(:white, self, [i, j])
          else
            grid[i][j] = NullPiece.instance
          end
            
            
              
            
        # if i == 0 || i == 1 
        #   grid[i][j] = Bishop.new(:black, self, [i, j])

        # elsif i == 6 || i == 7
        #   grid[i][j] = Bishop.new(:white, self, [i, j])

        


      end
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end



  def move_piece(start_pos, end_pos)

    if !valid_pos?(start_pos)
      raise "start position out of bounds, dude!"
    end

    if grid[start_pos[0]][start_pos[1]].is_a?(NullPiece)
      raise "no piece there, bro!"
    end


    if !valid_pos?(end_pos)
      raise "position out of bounds, guy!"
    end

    grid[end_pos[0]][end_pos[1]] = grid[start_pos[0]][start_pos[1]]

    grid[start_pos[0]][start_pos[1]] = NullPiece.instance
  end

  def valid_pos?(pos)
    return false if !( (0..7) === pos[0] &&  (0..7) === pos[1] )
    true
  end




end