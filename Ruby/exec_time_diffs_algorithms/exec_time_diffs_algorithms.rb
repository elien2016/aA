# Largest Contiguous Sub-sum
list1 = [5, 3, -7]
list2 = [2, 3, -6, 7, -6, 7]
list3 = [-5, -1, -3]

# phase one
def largest_contiguous_subsum(list)
  sub_arrs = []
  list.each_with_index do |el, i|
    (i...list.length).each { |j| sub_arrs << list[i..j] }
  end
  sub_arrs.map { |arr| arr.sum }.max
end

p largest_contiguous_subsum(list1)
p largest_contiguous_subsum(list2)
p largest_contiguous_subsum(list3)

# phase two
def largest_contiguous_subsum_better(list)
  
end