class Player
  attr_reader :name
  attr_accessor :hand, :pot

  def initialize(name, pot = 1)
    @name = name
    @hand = nil
    @pot = pot
  end

  def cards
    @hand.cards
  end

  def discard
    system('clear')
    puts "#{@name}, do you wish to discard any cards? (y/n)"
    print '> '
    discard = gets.chomp.strip
    return nil if discard != 'y'
    puts
    see_hand
    begin
      puts 'Enter the indix/indices (1 ~ 5, left to right) of the card(s) you wish to discard (e.g. 2 3), up to 3 cards.'
      print '> '
      indices = gets.chomp.split
      indices.map! { |str| Integer(str) }
      raise 'You can only discard up to 3 cards' if indices.length > 3
      raise 'Enter only numbers between 1 and 5 with space between them' if
        !indices.all? { |n| n.between?(1, 5) }
    rescue ArgumentError, RuntimeError => e
      puts "Error: #{e.message}"
      puts
      retry
    end
    indices.map! { |i| i - 1 }
    indices
  end

  def see_hand
    print "#{@name}, your cards:"
    cards.each { |card| print " #{card}" }
    puts
    puts
  end

  def prompt
    puts "Enter f to fold, c to call or check, r to raise"
    print '> '
    input = gets.chomp.strip
    if input == 'f' || input == 'c'
      return input
    elsif input == 'r'
      begin 
        puts "Enter the amount you'd like to raise"
        print '> '
        amt = Integer(gets.chomp)
      rescue ArgumentError => e
        puts "Error: #{e.message}"
        puts
        retry
      end
      return amt
    else
      raise 'Not a valid command'
    end
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    puts
    retry
  end

  def start_over(hand, pot = 1)
    @hand = hand
    @pot = pot
  end
end