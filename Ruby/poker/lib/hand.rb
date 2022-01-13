require_relative 'compare_hands'

class Hand
  extend CompareHands

  HANDS = %i(high_card one_pair two_pair three_of_a_kind straight flush full_house
    four_of_a_kind straight_flush).freeze

  attr_reader :cards, :hand

  def initialize(cards)
    @cards = cards
    @hand = check_hand(cards)
  end

  def check_hand(cards)
    HANDS[1..-1].reverse.each do |hand|
      return hand if send("#{hand}?", cards)
    end
    HANDS.first
  end

  def self.winner(hands)
    rankings = Hash.new { [] }
    hands.each { |hand| rankings[hand.hand] += [hand] }
    highest_idx = rankings.keys.map { |k| HANDS.index(k) }.max
    highest_hand = HANDS[highest_idx]
    rankings[highest_hand].length == 1 ? (return rankings[highest_hand]) :
      (return Hand.highest(highest_hand, rankings[highest_hand]))
  end

  private

  def straight_flush?(cards)
    straight?(cards) && flush?(cards)
  end

  def count_ranks(cards)
    count = {}
    cards.each do |card|
      count[card.rank] = count[card.rank].nil? ? 1 : count[card.rank] + 1
    end
    count
  end

  def four_of_a_kind?(cards)
    count = count_ranks(cards)
    count.has_value?(4)
  end

  def full_house?(cards)
    count = count_ranks(cards)
    count.has_value?(3) && count.has_value?(2)
  end

  def flush?(cards)
    suit = cards[0].suit
    cards[1..-1].all? { |card| card.suit == suit }
  end

  def straight?(cards)
    ranks = cards.inject([]) { |arr, card| arr << card.rank }
    return false if ranks != ranks.uniq
    ranks.max == ranks.min + 4
  end

  def three_of_a_kind?(cards)
    count = count_ranks(cards)
    count.has_value?(3)
  end

  def two_pair?(cards)
    count = count_ranks(cards)
    count.length == 3
  end

  def one_pair?(cards)
    count = count_ranks(cards)
    count.has_value?(2)
  end

  def inspect
    "#<Hand:#{object_id} @hand:#{@hand}>"
  end
end