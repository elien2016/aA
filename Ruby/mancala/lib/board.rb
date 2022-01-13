class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { [] }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (@cups[0..5] + @cups[7..12]).each { |arr| arr.replace([:stone, :stone, 
      :stone, :stone]) }
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' if start_pos < 0 || start_pos > 13
    raise 'Starting cup is empty' if @cups[start_pos].count == 0
  end

  def make_move(start_pos, current_player_name)
    @cups[start_pos] = []

    i = start_pos + 1
    round = 0
    other_store_idx = current_player_name == @name1 ? 13 : 6
    while round < 4
      if i == other_store_idx
        i = (i + 1) % 14
        next
      end
      @cups[i].push(:stone)
      i = (i + 1) % 14
      round += 1
    end
    render
    next_turn(i == 0 ? 13 : i - 1)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if [6, 13].include?(ending_cup_idx)

    @cups[ending_cup_idx].count == 1 ? (return :switch) :
      (return ending_cup_idx)
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
    if @cups[6].count > @cups[13].count
      return @name1
    elsif @cups[13].count > @cups[6].count
      return @name2
    else
      :draw
    end
  end
end
