# phase one
def first_anagram?(str1, str2)
  arr = str1.split('')
  permutations = []
  arr.permutation { |permutation| permutations << permutation.join }
  permutations.include?(str2)
end

p first_anagram?('cat', 'tac')

# phase two
def second_anagram?(str1, str2)
  arr1, arr2 = str1.split(''), str2.split('')

  arr1.each do |ch|
    i = arr2.index(ch)
    return false if i.nil?
    arr2.delete_at(i)
  end
  arr2.empty?
end

puts '-' * 20 + 'second' + '-' * 20
p second_anagram?('cat', 'tac')
p second_anagram?('cat', 'tak')
p second_anagram?('cat', 'bat')

# phase three
def third_anagram?(str1, str2)
  arr1, arr2 = str1.split('').sort, str2.split('').sort
  arr1 == arr2
end

puts '-' * 20 + 'third' + '-' * 20
p third_anagram?('cat', 'tac')
p third_anagram?('cat', 'tak')
p third_anagram?('cat', 'bat')

# phase four
def fourth_anagram1?(str1, str2)
  hash1, hash2 = Hash.new(0), Hash.new(0)
  str1.split('').each { |ch| hash1[ch] += 1 }
  str2.split('').each { |ch| hash2[ch] += 1 }
  hash1 == hash2
end

puts '-' * 20 + 'fourth_v1' + '-' * 20
p fourth_anagram1?('cat', 'tac')
p fourth_anagram1?('cat', 'tak')
p fourth_anagram1?('cat', 'bat')

def fourth_anagram2?(str1, str2)
  hash1 = Hash.new(0)
  str1.split('').each { |ch| hash1[ch] += 1 }
  str2.split('').each { |ch| hash1[ch] -= 1 }
  hash1.values.all? { |ct| ct == 0 }
end

puts '-' * 20 + 'fourth_v2' + '-' * 20
p fourth_anagram2?('cat', 'tac')
p fourth_anagram2?('cat', 'tak')
p fourth_anagram2?('cat', 'bat')