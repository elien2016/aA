require_relative "tile"

class Board
    attr_accessor :revealed_ct

    def initialize
        @board = Array.new(9) { Array.new(9) }
        @revealed_ct = 0
    end

    def set_bombs
        (0..8).each do |i|
            (0..8).each do |j|
                self[[i, j]] = Tile.new(false, [i, j])
            end
        end
        9.times do
            row = rand(0..8)
            col = rand(0..8)
            self[[row, col]].bombed = true
        end
    end

    def render(game_over)
        puts "  #{(0..8).to_a.join(' ')}"
        @board.each_with_index do |row, i|
            symbols = []
            row.each do |tile|
                if tile.flagged
                    symbols << 'F'
                elsif !tile.revealed
                    if game_over
                        if tile.bombed == true
                            symbols << 'x'
                        else
                            symbols << '*'
                        end
                    else
                        symbols << '*'
                    end
                elsif tile.bomb_ct == 0
                    symbols << '_'
                else
                    symbols << tile.bomb_ct.to_s
                end
            end
            puts "#{i} #{symbols.join(' ')}"
        end
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    private

    def []=(pos, val)
        i, j = pos
        @board[i][j] = val
    end
end