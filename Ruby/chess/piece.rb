class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    if self.class != NullPiece
      symbol.to_s
    else
      "  "
    end
  end

  def empty?
    return true if self.class == NullPiece
    false
  end

  def valid_moves
    moves.select { |pos| !move_into_check?(pos) }
  end

  def move_into_check?(end_pos)
    pos = @pos
    end_pos_piece_copy = @board[end_pos]
    @board.move_piece!(pos, end_pos)
    into_check = @board.in_check?(@color)
    @board.move_piece!(end_pos, pos)
    @board[end_pos] = end_pos_piece_copy
    into_check
  end

  def inspect
    "#<#{self.class}:#{object_id} @color=#{@color}, @pos=#{@pos}>"
  end
end