require_relative 'player'

class HumanPlayer < Player
  def make_move
    system('clear')
    puts "#{@color.capitalize}'s turn"
    puts
    @display.render
    @display.cursor.get_input
  end
end