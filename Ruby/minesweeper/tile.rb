require_relative 'board'

class Tile
    attr_reader :flagged, :revealed, :bomb_ct
    attr_accessor :bombed
    
    def initialize(bombed, pos)
        @bombed = bombed
        @pos = pos
        @revealed = false
        @flagged = false
        @bomb_ct = 0
    end
    
    def reveal(board)
        return true if @bombed == true
        @revealed = true
        board.revealed_ct += 1
        neighbors = neighbors(board)
        @bomb_ct = neighbor_bomb_count(neighbors)
        return if @bomb_ct != 0
        neighbors.each do |tile|
            tile.reveal(board) if !tile.revealed
        end
        false
    end

    def neighbors(board)
        arr = []
        start_i = @pos[0]
        start_j = @pos[1]
        (start_i - 1..start_i + 1).each do |i|
            if i >= 0 && i <= 8
                (start_j - 1..start_j + 1).each do |j|
                    if j >= 0 && j <= 8
                        unless i == start_i && j == start_j
                            arr << board[[i, j]]
                        end
                    end
                end
            end
        end
        arr
    end

    def neighbor_bomb_count(neighbors)
        ct = 0
        neighbors.each do |tile|
            ct += 1 if tile.bombed == true
        end
        ct
    end

    def flag
        @flagged = true
    end

    def deflag
        @flagged = false
    end
end