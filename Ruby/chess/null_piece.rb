require_relative 'piece'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
    
  end

  def moves
    return []
  end

  def color
    :transparent
  end

  def symbol
    :Null
  end
end