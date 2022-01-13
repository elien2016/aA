require_relative 'tile.rb'

class Board
  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    puzzle_file = File.open(file)
    puzzle = puzzle_file.readlines.map(&:chomp)
    puzzle_file.close

    puzzle.map! do |str|
      str = str.split('').map!(&:to_i)
      str.map! do |num|
        given = num != 0 ? true : false
        tile = Tile.new(num, given)
      end
    end

    puzzle
  end

  def update(pos, new_val)
    x, y = pos[0], pos[1]
    @grid[x][y].val = new_val
  end

  def render
    @grid.each do |arr|
      str = ''
      arr.each { |tile| str << "#{tile.to_s} " }
      puts str
    end
  end

  def solved?
    check_lines(@grid) && check_lines(@grid.transpose) && check_lines(
      squares_into_grid)
  end

  def check_lines(grid)
    grid.each do |arr|
      int_arr = arr.map { |tile| tile.val }
      return false if int_arr.uniq != int_arr ||
        int_arr.any? { |n| n < 1 || n> 9 }
    end
    true
  end

  def squares_into_grid
    grid = []

    start_row = 0
    3.times do
      start_column = 0
      3.times do
        arr = []
        i = start_row
        j = start_column
        3.times do
          arr += @grid[i][j..j+2]
          i += 1
        end
        grid << arr
        start_column += 3
      end
      start_row += 3
    end

    grid
  end

end