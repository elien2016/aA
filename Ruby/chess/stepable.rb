module Stepable
  def moves
    moves = []
    move_diffs.each do |move_diff|
      x = @pos[0] + move_diff[0]
      y = @pos[1] + move_diff[1]
      if x >= 0 && x <=7 && y >= 0 && y <= 7
        if !(!@board[[x, y]].empty? && @board[[x, y]].color == @color)
          moves << [x, y]
        end
      end
    end
    moves
  end
end