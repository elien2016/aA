def my_uniq(arr)
  arr_uniq = []
  arr.each do |el|
    arr_uniq << el if !arr_uniq.include?(el)
  end
  arr_uniq
end

class Array
  def two_sum
    pairs = []
    self.each_with_index do |el, i|
      j = i + 1
      while j < self.length
        pairs << [i, j] if el + self[j] == 0
        j += 1
      end
    end
    pairs
  end
end

def my_transpose(arr_2d)
  dim = arr_2d.length
  arr = Array.new(dim) { [] }
  
  arr_2d.each do |arr_inner|
    arr_inner.each_with_index do |el, i|
      arr[i] << el
    end
  end
  arr
end

# [3, 9, 2, 6, 10, 1, 4]
def pick_stock(arr)
  max_profit = 0
  best_trading_days = nil

  arr.each_with_index do |price, day_buy|
    day_sell = day_buy + 1
    while day_sell < arr.length
      profit = arr[day_sell] - price
      if profit > max_profit
        max_profit = profit
        best_trading_days = [day_buy, day_sell]
      end
      day_sell += 1
    end
  end
  best_trading_days
end

# Tower of Hanoi
class Game
  attr_reader :piles

  def initialize
    @piles = [[4, 3, 2, 1], [], []]
  end

  def move(arr)
    pile_from = arr[0]
    pile_to = arr[1]
    raise 'The pile_from is empty' if @piles[pile_from].empty?

    disc = @piles[pile_from].pop
    @piles[pile_to].push(disc)
  end

  def won?
    return true if @piles[2] == [4, 3, 2, 1]
    false
  end
end