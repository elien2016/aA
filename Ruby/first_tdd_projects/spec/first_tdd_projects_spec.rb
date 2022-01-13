require 'first_tdd_projects'

describe '#my_uniq' do
  let(:arr) { [1, 2, 1, 3, 3] }

  it 'removes duplicates from an array' do
    expect(my_uniq(arr)).to match_array(arr.uniq)
  end

  it 'returns the unique elements in the order in which they first appeared' do
    expect(my_uniq(arr)).to eq([1, 2, 3])
  end
end

describe 'Array#two_sum' do
  let(:arr) { [-1, 0, 2, -2, 1] }

  it 'finds all pairs of positions where the elements at those positions sum to zero' do
    expect(arr.two_sum).to match_array([[0, 4], [2, 3]])
  end

  it "returns the array of pairs sorted 'dictionary-wise'" do
    expect(arr.two_sum).to eq([[0, 4], [2, 3]])
  end
end

describe '#my_transpose' do
  let(:arr) {[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]}

  it 'transposes a matrix' do
    expect(my_transpose(arr)).to eq([[0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
      ])
  end
end

describe '#pick_stock' do
  let(:prices) { [3, 9, 2, 6, 10, 1, 4] }

  it 'returns the most profitable pair of days to first buy the stock and then sell it' do
    expect(pick_stock(prices)).to eq([2, 4])
  end
end

describe Game do
  subject(:game) { Game.new }

  describe '#move' do
    it 'moves a disc to a different pile' do
      disc = game.piles[0].last
      game.move([0, 2])
      expect(game.piles[2].last).to eq(disc)
    end

    it 'raises error if pile_from is empty' do
      expect { game.move([2, 1]) }.to raise_error('The pile_from is empty')
    end
  end

  describe '#won?' do
    it 'returns false when not won' do
      expect(game.won?).to be false
    end

    it 'returns true when won' do
      game.move([0, 1])
      game.move([0, 2])
      game.move([1, 2])
      game.move([0, 1])
      game.move([2, 0])
      game.move([2, 1])
      game.move([0, 1])
      game.move([0, 2])
      game.move([1, 2])
      game.move([1, 0])
      game.move([2, 0])
      game.move([1, 2])
      game.move([0, 1])
      game.move([0, 2])
      game.move([1, 2])
      expect(game.won?).to be true
    end
  end
end