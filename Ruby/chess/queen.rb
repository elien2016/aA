require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable

  def symbol
    :Qn
  end

  private

  def move_dirs
    [:horizontal, :diagonal]
  end
end