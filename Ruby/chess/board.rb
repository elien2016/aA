require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'knight'
require_relative 'king'
require_relative 'pawn'
require_relative 'null_piece'

class Board
  attr_reader :rows

  def initialize
    @rows = Array.new(8) { Array.new(8) { NullPiece.instance } }
    add_pieces

    @null_piece = NullPiece.instance
  end

  def [](pos)
    row, column = pos
    @rows[row][column]
  end

  def []=(pos, val)
    row, column = pos
    @rows[row][column] = val
  end

  def move_piece(color, start_pos, end_pos)
    raise 'No piece at start_pos' if self[start_pos].empty?
    raise 'Not your piece' if self[start_pos].color != color
    raise 'Illegal move' if !self[start_pos].moves.include?(end_pos)
    raise 'The piece cannot move there' if !self[end_pos].empty? && self[end_pos].color == self[start_pos].color
    raise 'The move will leave you in check' if self[start_pos].move_into_check?(end_pos)
    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    self[end_pos], self[start_pos] = self[start_pos], @null_piece
    self[end_pos].pos = end_pos
  end

  def valid_pos?(pos)
    return true if pos[0] >= 0 && pos[0] <= 7 && pos[1] >= 0 && pos[1] <= 7
    false
  end

  def add_pieces
    @rows[0] = make_row_powerful_pieces(:black)
    @rows[7] = make_row_powerful_pieces(:white)
    @rows[1] = make_row_pawns(:black)
    @rows[6] = make_row_pawns(:white)
  end

  def checkmate?(color)
    own_pieces = @rows.flatten.select { |piece| piece.color == color }
    valid_moves = []
    own_pieces.each { |piece| valid_moves += piece.valid_moves }
    return true if in_check?(color) && valid_moves.empty?
    false
  end

  def in_check?(color)
    king_pos = find_king(color)
    opposing_pieces = @rows.flatten.select { |piece| piece.color != color &&
      piece.color != :transparent }
    opposing_pieces.each do |piece|
      piece.moves.each do |move|
        return true if move == king_pos
      end
    end
    false
  end

  def find_king(color)
    @rows.each do |row|
      row.each do |piece|
        return piece.pos if piece.class == King && piece.color == color
      end
    end
  end

  private

  def make_row_powerful_pieces(color)
    pieces = Array.new(8)
    row = color == :black ? 0 : 7
    pieces[0], pieces[7] = Rook.new(color, self, [row, 0]), Rook.new(color, self, [row, 7])
    pieces[1], pieces[6] = Knight.new(color, self, [row, 1]), Knight.new(color, self, [row, 6])
    pieces[2], pieces[5] = Bishop.new(color, self, [row, 2]), Bishop.new(color, self, [row, 5])
    pieces[3] = Queen.new(color, self, [row, 3])
    pieces[4] = King.new(color, self, [row, 4])
    pieces
  end

  def make_row_pawns(color)
    pawns = []
    row = color == :black ? 1 : 6
    8.times { |i| pawns << Pawn.new(color, self, [row, i])}
    pawns
  end
end
