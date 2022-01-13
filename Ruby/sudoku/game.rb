require_relative 'board.rb'

class Game
  def play
    puts "Which sudoku would you like to play? (Enter a number 1~3)"
    while true
      board_idx = prompt.to_i
      break if valid_board_idx?(board_idx)
    end
    puts
    b = Board.new(Board.from_file("./puzzles/sudoku#{board_idx}.txt"))
   
    until b.solved?
      b.render
      print "\nEnter a position and value, separated by space (e.g. '2,7 5'): "
      while true
        input = prompt
        break if valid_input?(input)
      end
      input = input.split(" ")
      pos = get_pos(input)
      val = get_val(input)
      b.update(pos, val)
      print "-"*40
      puts
    end

    b.render
    puts
    puts "Would you like to play another game? (y/n)"
    while true
      play_again = prompt
      break if play_again == 'y' || 'n'
    end
    play until play_again == "n"
  end

  def prompt
    gets.chomp
  end

  def valid_board_idx?(n)
    n >= 1 && n <= 3 ? true : false
  end

  def valid_input?(input)
    nums = [input[0], input[2], input[4]].map!(&:to_i)
    return false if input.length != 5 || input[1] != ',' || input[3] != ' ' ||
      nums.any? { |n| n < 0 || n > 8 } 
    true
  end

  def get_pos(input)
    pos = input[0].split(',').map!(&:to_i)
  end

  def get_val(input)
    input[1].to_i
  end

end

g = Game.new
g.play