require 'colorize'

class Tile
  attr_reader :val
  
  def initialize(val, given)
    @val = val
    @given = given
  end

  def to_s
    val_s = @val == 0 ? '_' : @val.to_s
    val_s = val_s.colorize(:light_magenta) if @given == true
    val_s
  end

  def val=(new_val)
    if @given == false
      @val = new_val
    else
      puts "You can't change any value that's given."
    end
  end
end