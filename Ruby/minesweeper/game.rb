require 'yaml'
require_relative 'board'

class Game
    attr_accessor :board

    def initialize
        @board = Board.new
        @board.set_bombs
    end
    
    def play
        game_over = false
        welcome

        until won?
            @board.render(game_over)

            input = prompt
            until valid_input?(input, @board)
                input = prompt
            end

            if input.length == 1
                save_game(self) if input[0] == 's'
                return
            else
                parse_move(input, game_over)
            end

            render_separator
        end

        puts "You won!"
        game_over = true
        render_end_game(game_over)
    end

    def welcome
        puts
        puts "Hello, welcome to Minesweeper."
        puts "***When prompted, enter 'r' for reveal, 'f' for flag, or 'd' for \
deflag, followed by space and a position separated by a comma (e.g. r 7,3).***"
        puts "Would you like to open a previously saved game from file? (y/n)"
        print '> '
        input = gets.chomp
        if input == 'y'
            puts
            print "Enter the filename (without extension): "
            file_name = gets.chomp
            load_game(file_name)
        end
        puts
    end

    def prompt
        puts
        puts "Enter your move (or 'q' to quit, 's' to save and quit):"
        print '> '
        gets.chomp
    end

    def valid_input?(input, board)
        return false if !(valid_move?(input, board) || valid_cmd?(input))
        true
    end

    def valid_cmd?(input)
        action = input[0]

        if input.length != 1
            return false
        elsif !(action == 'q' || action == 's' || action == 'l')
            return false
        end
        true
    end

    def valid_move?(input, board)
        action = input[0]
        i = input[2].to_i
        j = input[4].to_i
        comma = input[3]

        if input.length !=5
            return false
        elsif !(action == 'r' || action == 'f' || action == 'd')
            return false
        elsif i > 8 || i < 0 || j > 8 || j < 0
            return false
        elsif comma != ','
            return false
        elsif action == 'r' && board[[i, j]].flagged == true
            puts
            puts "The square is flagged. Deflag it first."
            return false
        end
        true
    end

    def parse_move(input, game_over)
        pos = get_pos(input)

        if input[0] == 'f'
            @board[pos].flag
        elsif input[0] == 'd'
            @board[pos].deflag
        else
            if @board[pos].reveal(@board)
                puts
                puts "You hit a bomb. Game over."
                game_over = true
                render_end_game(game_over)
                return
            end
        end
    end

    def render_separator
        puts
        puts '-'*42
        puts
    end

    def render_end_game(game_over)
        puts
        @board.render(game_over)
        puts
    end

    def get_pos(input)
        input[2..-1].split(',').map(&:to_i)
    end

    def won?
        return true if @board.revealed_ct == 71
        false
    end

    def save_game(game)
        path = Dir.pwd
        puts
        print "filename (without extension): "
        file_name = "#{gets.chomp}.yml"
        puts "Game saved."
        file_path = File.join(path, file_name)
        File.open(file_path, 'w') { |file| file.write(game.to_yaml) }
    end

    def load_game(file_name)
        saved_game = YAML.load(File.read("#{file_name}.yml"))
        @board = saved_game.board
    end
end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end