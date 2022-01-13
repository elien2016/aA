require 'card'

describe Card do
  describe '#initialize' do
    let(:three_of_spades) { Card.new(3, :spades) }

    it 'sets a rank' do
      expect(three_of_spades.rank).to eq(3)
    end

    it 'sets a suit' do
      expect(three_of_spades.suit).to eq(:spades)
    end
  end

  describe '#to_s' do
    let(:three_of_spades) { Card.new(3, :spades) }
    let(:queen_of_hearts) { Card.new(12, :hearts) }

    it 'returns string form of number if number is less or equal to 10' do
      expect(three_of_spades.to_s[0]).to eq('3')
    end

    it 'returns special string if number is greater than 10' do
      expect(queen_of_hearts.to_s[0]).to eq('Q')
    end

    it 'returns correct symbol of the suit' do
      expect(queen_of_hearts.to_s[1]).to eq("\u2661")
    end
  end
end