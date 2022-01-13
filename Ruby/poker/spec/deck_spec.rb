require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'creates a deck of 52 cards' do
      expect(deck.cards.length).to eq(52)
    end

    it 'creates a deck that includes 4 cards of ranks 1 ~ 14' do
      deck.ranks.all? do |rank|
        deck.cards.count { |card| card.rank == rank } == 4
      end
    end

    it 'creates a deck that includes 4 suits of each rank' do
      deck.ranks.all? do |rank|
        cards = deck.cards.select { |card| card.rank == rank }
        deck.suits.all? do |suit|
          cards.count { |card| card.suit == suit } == 1
        end
      end
    end
  end
end