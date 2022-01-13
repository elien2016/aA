require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      if @board.tied?
        return false
      else
        return false if @board.winner == evaluator
        return true
      end
    end

    children_nodes = self.children
    if @next_mover_mark == evaluator
      children_nodes.each do |child_node|
        result = child_node.losing_node?(evaluator)
        return false if result == false
      end
      return true
    else
      children_nodes.each do |child_node|
        result = child_node.losing_node?(evaluator)
        return true if result == true
      end
      return false
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      if @board.tied?
        return false
      else
        return true if @board.winner == evaluator
        return false
      end
    end

    children_nodes = self.children
    if @next_mover_mark == evaluator
      children_nodes.each do |child_node|
        result = child_node.winning_node?(evaluator)
        return true if result == true
      end
      return false
    else
      children_nodes.each do |child_node|
        result = child_node.winning_node?(evaluator)
        return false if result == false
      end
      return true
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    arr = []
    next_mover_mark = @next_mover_mark == :x ? :o : :x
    (0..2).each do |row|
      (0..2).each do |col|
        if @board.empty?([row, col])
          board_copy = @board.dup
          board_copy[[row, col]] = @next_mover_mark
          arr << TicTacToeNode.new(board_copy, next_mover_mark, [row, col])
        end
      end
    end
    arr
  end
end
