require "colorize"
require_relative "cursor.rb"
require_relative "board.rb"


class Display
  attr_reader :board

  def initialize
    @board = Board.new()


    @cursor = Cursor.new([0,0], @board)
  end

  def display_loop
    while true
      render()
      @cursor.get_input()
      system "clear"
    end

  end

  def render
    @board.grid.each_with_index do |row, i|
      puts
      row.each_with_index do |square, j|

        bgcolor = :blue if (i + j).odd?
        bgcolor = :light_blue if (i + j).even?

        bgcolor = :red if [i,j] == @cursor.cursor_pos

        if square == nil
           string = "   "
        else
           string = square.symbol
           piece_color = square.color
        end



        print string.colorize(:color => piece_color, :background => bgcolor)
       
      end
    end
    nil

  end









end
