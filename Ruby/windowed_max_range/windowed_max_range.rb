# phase one: naive solution
def windowed_max_range(array, windowed_max_range)
  current_max_range = nil
  (windowed_max_range - 1...array.length).each do |j|
    window = array[j - windowed_max_range + 1..j]
    min, max = window.min, window.max
    current_max_range = max - min if current_max_range.nil? || max - min > current_max_range
  end
  current_max_range
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

# phase two
class MyQueue
  def initialize
    @store = []
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def enqueue(el)
    @store.push(el)
  end

  def dequeue
    @store.shift
  end
end

# phase three
class MyStack
  def initialize
    @store = []
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def pop
    @store.pop
  end

  def push(el)
    @store.push(el)
  end
end

# phase four
class StackQueue
  def initialize
    @in_stack = Stack.new
    @out_stack = Stack.new
  end

  def size
    @in_stack.size + @out_stack
  end

  def empty?
    @in_stack.empty? + @out_stack.empty?
  end

  def enqueue(val)
    @in_stack.push(val)
  end

  def dequeue
    queueify if @out_stack.empty?
    @out_stack.pop
  end

  private

  def queueify
    @out_stack.push(@in_stack.pop) until @in_stack.empty?
  end
end

# phase five
class MinMaxStack
  def initialize
    @store = MyStack.new
  end

  def peek
    @store.peek[:value] unless empty?
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def max
    @store.peek[:max] unless empty?
  end

  def min
    @store.peek[:min] unless empty?
  end

  def pop
    @store.pop[:value] unless empty?
  end

  def push(val)
    @store.push({
      max: new_max(val),
      min: new_min(val),
      value: val
    })
  end

  private

  def new_max(val)
    empty? ? val : [max, val].max
  end

  def new_min(val)
    empty? ? val : [min, val].min
  end
end

# phase six
class MinMaxStackQueue < StackQueue
  def initialize
    @in_stack, @out_stack = MinMaxStack.new, MinMaxStack.new
  end

  def max
    maxes = []
    maxes << @in_stack.max unless @in_stack.empty?
    maxes << @out_stack.max unless @out_stack.empty?
    maxes.max
  end

  def min
    mins = []
    mins << @in_stack.min unless @in_stack.empty?
    mins << @out_stack.min unless @out_stack.empty?
    mins.min
  end
end

# phase seven
def windowed_max_range2(array, windowed_max_range)
  i = 0
  current_max_range = nil
  window = MinMaxStackQueue.new
  windowed_max_range.times do
    window.enqueue(array[i])
    i += 1
  end
  
  loop do
    current_range = window.max - window.min
    current_max_range = current_range if current_max_range.nil? || current_range > current_max_range
    break if i == array.length
    window.dequeue
    window.enqueue(array[i])
    i += 1
  end
  current_max_range
end

puts
puts '-' * 20 + 'Final' + '-' * 20
p windowed_max_range2([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range2([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range2([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range2([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8