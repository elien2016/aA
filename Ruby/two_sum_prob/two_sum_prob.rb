arr = [5, 7, 0, 1]

# brute force
def bad_two_sum?(arr, target_sum)
  combinations = []
  arr.combination(2) { |combination| combinations << combination }
  combinations.map { |pair| pair.sum }.include?(target_sum)
end

p bad_two_sum?(arr, 6)
p bad_two_sum?(arr, 10)

# sorting
def okay_two_sum?(arr, target_sum)
  arr_sorted = arr.sort
  i, j = 0, arr_sorted.length - 1

  until i == j
    diff = target_sum - arr_sorted[i]
    if arr_sorted[j] == diff
      return true
    elsif arr_sorted[j] > diff
      j -= 1
    else
      i += 1
    end
  end
  false
end

p okay_two_sum?(arr, 6)
p okay_two_sum?(arr, 10)

# hash map
def two_sum?(arr, target_sum)
  hash = {}
  arr.each { |n| hash[n] = target_sum - n }
  bool = false
  hash.keys.each do |k|
    bool = hash.has_value?(k)
    bool = false if k == hash[k]
  end
  bool
end

p two_sum?(arr, 6)
p two_sum?(arr, 10)
p two_sum?([5, 7, 2, 0], 10)