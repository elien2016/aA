require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    root_node = TicTacToeNode.new(game.board, mark)
    root_node.children.each do |child_node|
      return child_node.prev_move_pos if child_node.winning_node?(mark)
    end
      root_node.children.each do |child_node|
      return child_node.prev_move_pos if !child_node.losing_node?(mark)
    end
    raise "Something's wrong. No non-losing nodes for computer."
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
