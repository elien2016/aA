require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable

  def symbol
    :Kg
    # ' ' + "\u2654".encode('utf-8')
  end

  protected

  def move_diffs
    [[0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1]]
  end
end