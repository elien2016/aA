module Slideable
  def moves
    moves = []
    dirs = []
    dirs += HORIZONTAL_DIRS if move_dirs.include?(:horizontal)
    dirs += DIAGONAL_DIRS if move_dirs.include?(:diagonal)
    dirs.each { |dir| moves += grow_unblocked_moves_in_dir(*dir) }
    moves
  end

  private

  HORIZONTAL_DIRS = [[0, -1], [-1, 0], [0, 1], [1, 0]]
  DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, 1], [1, -1]]

  def grow_unblocked_moves_in_dir(dx, dy)
    moves = []
    diff_x = dx
    diff_y = dy
    x = @pos[0] + diff_x
    y = @pos[1] + diff_y
    while x >= 0 && x <=7 && y >= 0 && y <= 7
      if !(!@board[[x, y]].empty? && @board[[x, y]].color == @color)
        moves << [x, y]
        break if !@board[[x, y]].empty? && @board[[x, y]] != @color
        diff_x += dx
        diff_y += dy
        x = @pos[0] + diff_x
        y = @pos[1] + diff_y
      else
        break
      end
    end
    moves
  end
end