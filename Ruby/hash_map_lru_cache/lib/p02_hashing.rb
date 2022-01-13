require 'byebug'
class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty?
    if self.length == 1
      if self.first.is_a?(Integer)
        return self.first
      elsif self.first.is_a?(String)
        return self.first.hash
      end
    end

    arr = self.map { |el| el.hash }
    diffs = []
    (1...arr.length).each { |i| diffs << arr[i - 1] - arr[i] }
    arr_new = [arr.first] + arr[1..-1].map.with_index { |el, i| [el, diffs[i]] }.flatten
    arr_new.inject { |acc, el| acc ^ el }
  end
end

class String
  def hash
    alphabet = ('a'..'z').to_a + ('A'..'Z').to_a
    arr = self.split('').map { |ch| alphabet.index(ch) }
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort_by(&:hash).hash
  end
end
