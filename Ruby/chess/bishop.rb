require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable

  def symbol
    :Bs
  end
  
  private

  def move_dirs
    [:diagonal]
  end
end