class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    system('clear')
    take_turn while !@game_over
    game_over_message
    puts @seq.join(' ')
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if !@game_over
      round_success_message
      @sequence_length += 1
      sleep(1)
      system('clear')
    end
  end

  def show_sequence
    add_random_color
    puts @seq.join(' ')
    sleep(@sequence_length)
    system('clear')
  end

  def require_sequence
    print "> "
    input = gets.chomp
    user_seq = input.split(' ')
    @game_over = true if user_seq != @seq
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Correct!"
  end

  def game_over_message
    puts "Game over!"
    puts "Score: #{@sequence_length}."
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

simon = Simon.new.play