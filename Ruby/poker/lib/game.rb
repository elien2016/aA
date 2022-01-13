require_relative 'deck'
require_relative 'player'
require_relative 'hand'

class Game
  def initialize
    @players = []
    4.times do |i|
      print "Player #{i + 1}, enter your name: "
      name = gets.chomp
      @players << Player.new(name)
    end
  end

  def calc_pot
    @players.map { |player| player.pot }.sum
  end

  def play
    @deck = Deck.new
    @deck.shuffle
    4.times { |i| @players[i].start_over(Hand.new(@deck.cards.shift(5))) }
    @current_players = [*@players]

    bet
    discard
    bet
    reveal
  end

  def bet
    raise = 0
    i = 0
    num_other_players = nil
    while i < @current_players.length || !num_other_players.nil?
      player = @current_players[i % @current_players.length]
      system('clear')
      player.see_hand
      current_bet
      action = player.prompt
      case action
      when 'f'
        @current_players.delete(player)
        i -= 1
        num_other_players -= 1 if !num_other_players.nil?
      when 'c'
        player.pot += raise
        num_other_players -= 1 if !num_other_players.nil?
      when Integer
        player.pot += raise
        raise = action
        player.pot += raise
        num_other_players = @current_players.length - 1
      end
      break if num_other_players == 0
      i += 1
    end
  end

  def current_bet
    arr = []
    @players.each { |p| arr << "#{p.name} $#{p.pot}" }
    puts "current bet: #{arr.join(', ')}"
    puts
  end

  def discard
    @current_players.each do |player|
      indices = player.discard
      next if indices.nil? || indices.empty?
      cards = player.cards.map.with_index do |card, i|
        if indices.include?(i)
          @deck.cards.shift
        else
          card
        end
      end
      player.hand = Hand.new(cards)
    end
  end

  def reveal
    system('clear')
    puts 'Round over.'
    puts
    @current_players.each { |player| puts "#{player.name}: #{
      player.cards.join(' ')}" }
    puts
    if @current_players.length == 1
      winners = [@current_players.first]
      winning_msg(winners)
    else
      winning_hands = Hand.winner(@current_players.map { |p| p.hand })
      winners = winning_hands.map { |h| @current_players.bsearch {
        |p| p.hand == h } }
      winning_msg(winners)
    end
    puts
    print 'Another round? (y/n) '
    more = gets.chomp
    play if more == 'y'
  end

  def winning_msg(winners)
    if winners.length == 1
      puts "#{winners.first.name} wins the pot, totalling $#{calc_pot}."
    else
      puts "#{winners.map { |p| p.name }.join(', ')} share the pot, totalling $#{calc_pot}."
    end
  end
end

Game.new.play if $PROGRAM_NAME == __FILE__