require_relative 'piece'

class Pawn < Piece
  def symbol
    :Pw
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def at_start_row?
    @color == :black ? (return true if @pos[0] == 1) : (return true if @pos[0] == 6)
    false
  end

  def forward_dir
    @color == :black ? 1 : -1
  end

  def forward_steps
    moves = []
    forward_1_pos = [@pos[0] + forward_dir, @pos[1]]
    forward_2_pos = [@pos[0] + 2 * forward_dir, @pos[1]]
    moves << forward_1_pos if @board[forward_1_pos].empty?
    moves << forward_2_pos if at_start_row? && @board[forward_2_pos].empty?
    moves
  end

  def side_attacks
    row = pos[0] + forward_dir
    column_1 = pos[1] - 1
    column_2 = pos[1] + 1
    moves = [[row, column_1], [row, column_2]]
    valid_attacks = []
    moves.each do |pos|
      if pos[0] >= 0 && pos[0] <= 7 && pos[1] >= 0 && pos[1] <= 7
        valid_attacks << pos if !@board[pos].empty? && @board[pos].color != @color
      end
    end
    valid_attacks
  end
end