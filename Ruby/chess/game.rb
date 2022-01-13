require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = { p1: HumanPlayer.new(:white, @display), p2: HumanPlayer.new(:black, @display) }
    @current_player = :p1
  end

  def play
    while !@board.checkmate?(@players[@current_player].color)
      begin
        start_pos, end_pos = nil, nil
        start_pos = @players[@current_player].make_move while start_pos.nil?
        end_pos = @players[@current_player].make_move while end_pos.nil?
        @board.move_piece(@players[@current_player].color, start_pos, end_pos)
      rescue => e
        puts e.message
        sleep(1.2)
        retry
      end
      swap_turn!
    end

    system('clear')
    @display.render
    puts
    puts "Game over. #{@players[@current_player].color.capitalize}'s king is checkmated."
    puts
  end

  private

  def swap_turn!
    @current_player = @current_player == :p1 ? :p2 : :p1
  end
end


if __FILE__ == $PROGRAM_NAME
  g = Game.new.play
end