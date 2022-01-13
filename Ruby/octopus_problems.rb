require_relative 'sorting_demo'

# Big O-ctopus and Biggest Fish
fish_group = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

# sluggish octopus
def sluggish(fish_group)
  fish_group.each do |fish|
    biggest = true
    fish_group.each { |other| biggest = false if other.length > fish.length }
    return fish if biggest
  end
end

puts sluggish(fish_group)

# dominant octopus
def dominant(fish_group)
  sorted = SortingDemo.merge_sort(fish_group) { |a, b| a.length <=> b.length}
  sorted.last
end

puts dominant(fish_group)

# clever octopus
def clever(fish_group)
  longest = fish_group.first
  fish_group[1..-1].each { |fish| longest = fish if fish.length > longest.length }
  longest
end

puts clever(fish_group)


# Dancing Octopus
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

# slow dance
def slow_dance(dir, tiles_arr)
  tiles_arr.each_with_index { |tile, i| return i if tile == dir }
  nil
end

puts slow_dance('up', tiles_array)
puts slow_dance('right-down', tiles_array)

# constant dance
tiles_hash = {
  'up' => 0,
  'right-up' => 1,
  'right' => 2,
  'right-down' => 3,
  'down' => 4,
  'left-down' => 5,
  'left' => 6,
  'left-up' => 7
}

def fast_dance(dir, tiles_hash)
  return tiles_hash[dir]
end

puts fast_dance('up', tiles_hash)
puts fast_dance('right-down', tiles_hash)