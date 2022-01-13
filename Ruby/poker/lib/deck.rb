require_relative 'card'

class Deck
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].freeze
  SUITS = [:clubs, :diamonds, :hearts, :spades].freeze

  attr_accessor :cards

  def initialize
    @cards = []
    ranks.each do |rank|
      suits.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def ranks
    RANKS
  end

  def suits
    SUITS
  end
end