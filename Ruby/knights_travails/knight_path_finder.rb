require_relative 'poly_tree_node'
require 'byebug'

class KnightPathFinder
    def initialize(pos)
        @start_pos = pos
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        build_move_tree
    end

    def self.valid_moves(pos)
        x = pos[0]
        y = pos[1]
        arr = [[x+1, y+2], [x+2, y+1], [x+2, y-1], [x+1, y-2],
            [x-1, y+2], [x-2, y+1], [x-2, y-1], [x-1, y-2]]
        i = 0
        until i == arr.length
            if arr[i][0] < 0 || arr[i][0] > 7 || arr[i][1] < 0 || arr[i][1] > 7
                arr.delete_at(i)
            else
                i += 1
            end
        end
        arr
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        moves -= (moves & @considered_positions)
        @considered_positions += moves
        moves
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            el = queue.shift
            positions = new_move_positions(el.value)
            positions.each do |pos|
                child = PolyTreeNode.new(pos)
                queue << child
                child.parent = el
            end
        end
    end

    def find_path(end_pos)
        target_node = @root_node.bfs(end_pos)
        trace_path_back(target_node)
    end

    def trace_path_back(node)
        arr = [node.value]
        parent = node.parent
        until parent == nil
            arr.unshift(parent.value)
            parent = parent.parent
        end
        arr
    end
end
