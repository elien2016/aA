require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    # puts "   #{(0..7).to_a.join('   ')}"
    # puts
    # (0..7).each do |i|
    #   print "#{i}  "
    #   @board.rows[i].each_with_index do |piece, j|
    #     print_colorized_piece(piece, j, i.even?, i)
    #   end

    #   puts
    #   print '   '
    #   (0..7).each_with_index do |j|
    #     if [i, j] == @cursor.cursor_pos
    #       @cursor.selected ? (print '    '.on_green) :
    #         (print '    '.on_light_yellow)
    #     elsif i.even?
    #       j.even? ? (print '    '.on_white) : (print '    '.on_black)
    #     else
    #       j.even? ? (print '    '.on_black) : (print '    '.on_white)
    #     end
    #   end
    #   puts
    # end

    puts "   #{('a'..'h').to_a.join('   ')}"
    (0..7).each do |i|
      print "#{8 - i} "
      @board.rows[i].each_with_index do |piece, j|
        print_colorized_piece(piece, j, i.even?, i)
      end
      print " #{8 - i}"

      puts
      print '  '
      (0..7).each_with_index do |j|
        if [i, j] == @cursor.cursor_pos
          @cursor.selected ? (print '    '.on_green) :
            (print '    '.on_light_yellow)
        elsif i.even?
          j.even? ? (print '    '.on_white) : (print '    '.on_black)
        else
          j.even? ? (print '    '.on_black) : (print '    '.on_white)
        end
      end
      puts
    end
    puts "   #{('a'..'h').to_a.join('   ')}"
  end

  def print_colorized_piece(piece, j, even, i)
    if [i, j] == @cursor.cursor_pos
      if @board[[i, j]].color == :black || @board[[i, j]].color == :transparent
        @cursor.selected ? (print "#{piece.to_s}  ".red.on_green) :
          (print "#{piece.to_s}  ".red.on_light_yellow)
      elsif @board[[i, j]].color == :white || @board[[i, j]].color == :transparent
        @cursor.selected ? (print "#{piece.to_s}  ".red.on_green) :
          (print "#{piece.to_s}  ".blue.on_light_yellow)
      end

      return
    end
    bool = even ? true : false
    case [piece.color, j.even?]
    when [:black, bool]
      print "#{piece.to_s}  ".red.on_white
    when [:black, !bool]
      print "#{piece.to_s}  ".red.on_black
    when [:white, bool]
      print "#{piece.to_s}  ".blue.on_white
    when [:white, !bool]
      print "#{piece.to_s}  ".blue.on_black
    when [:transparent, bool]
      print "#{piece.to_s}  ".on_white
    when [:transparent, !bool]
      print "#{piece.to_s}  ".on_black
    end
  end
end
