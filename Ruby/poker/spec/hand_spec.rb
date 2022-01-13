require 'hand'

describe Hand do
  let(:straight_flush) do
    arr = []
    (7..11).each { |n| arr << Card.new(n, :clubs) }
    arr
  end

  let(:four_of_a_kind) do
    arr = []
    [:clubs, :diamonds, :hearts, :spades].each do |suit|
      arr << Card.new(5, suit)
    end
    arr << Card.new(2, :diamonds)
    arr
  end

  let(:full_house) do
    arr = []
    [:clubs, :diamonds, :hearts].each do |suit|
      arr << Card.new(6, suit)
    end
    arr << Card.new(13, :clubs)
    arr << Card.new(13, :hearts)
    arr
  end

  let(:full_house) do
    arr = []
    [:clubs, :diamonds, :hearts].each do |suit|
      arr << Card.new(6, suit)
    end
    arr << Card.new(13, :clubs)
    arr << Card.new(13, :hearts)
    arr
  end

  let(:flush) do
    arr = []
    arr << Card.new(11, :diamonds)
    arr << Card.new(9, :diamonds)
    arr << Card.new(8, :diamonds)
    arr << Card.new(4, :diamonds)
    arr << Card.new(3, :diamonds)
    arr
  end

  let(:straight) do
    arr = []
    arr << Card.new(10, :diamonds)
    arr << Card.new(9, :hearts)
    arr << Card.new(8, :spades)
    arr << Card.new(7, :diamonds)
    arr << Card.new(6, :clubs)
    arr
  end

  let(:three_of_a_kind) do
    arr = []
    [:clubs, :diamonds, :hearts].each do |suit|
      arr << Card.new(12, suit)
    end
    arr << Card.new(9, :hearts)
    arr << Card.new(2, :spades)
    arr
  end

  let(:two_pair) do
    arr = []
    arr << Card.new(11, :hearts)
    arr << Card.new(11, :spades)
    arr << Card.new(3, :clubs)
    arr << Card.new(3, :spades)
    arr << Card.new(2, :hearts)
    arr
  end

  let(:one_pair) do
    arr = []
    arr << Card.new(10, :hearts)
    arr << Card.new(10, :spades)
    arr << Card.new(8, :clubs)
    arr << Card.new(7, :spades)
    arr << Card.new(4, :hearts)
    arr
  end

  let(:high_card) do
    arr = []
    arr << Card.new(13, :hearts)
    arr << Card.new(12, :spades)
    arr << Card.new(7, :clubs)
    arr << Card.new(4, :spades)
    arr << Card.new(3, :hearts)
    arr
  end

  describe '#initialize' do
    it 'creates an instance of Hand' do
      expect { Hand.new(flush) }.to_not raise_error
    end

    it 'sets the correct hand (flush)' do
      expect(Hand.new(flush).hand).to eq(:flush)
    end

    it 'sets the correct hand (straight)' do
      expect(Hand.new(straight).hand).to eq(:straight)
    end

    it 'sets the correct hand (straight flush)' do
      expect(Hand.new(straight_flush).hand).to eq(:straight_flush)
    end

    it 'sets the correct hand (four of a kind)' do
      expect(Hand.new(four_of_a_kind).hand).to eq(:four_of_a_kind)
    end

    it 'sets the correct hand (full house)' do
      expect(Hand.new(full_house).hand).to eq(:full_house)
    end

    it 'sets the correct hand (three of a kind)' do
      expect(Hand.new(three_of_a_kind).hand).to eq(:three_of_a_kind)
    end

    it 'sets the correct hand (two pair)' do
      expect(Hand.new(two_pair).hand).to eq(:two_pair)
    end

    it 'sets the correct hand (one pair)' do
      expect(Hand.new(one_pair).hand).to eq(:one_pair)
    end

    it 'sets the correct hand (high card)' do
      expect(Hand.new(high_card).hand).to eq(:high_card)
    end
  end
end