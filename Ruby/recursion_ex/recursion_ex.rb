# Warmup
def range(i, j)
    return [i] if i == j - 1
    return [] if j < i
    arr = []
    arr += [i]
    i2 = i + 1
    arr += range(i2, j)

    arr
end

def sum_recursive(arr)
    return arr[0] if arr.length == 1
    i = 0
    sum = 0
    sum += arr[i]
    i += 1
    sum += sum_resursive(arr[i..-1])

    sum
end

def sum_iterative(arr)
    sum = 0
    arr.each { |n| sum += n }
    sum
end

# Exponentiation
def exp_1(b, n)
    return 1 if n == 0
    result = b
    i = n - 1
    result *= exp_1(b, i)

    result
end

def exp_2(b, n)
    return 1 if n == 0
    return b if n == 1
    result = 1
    if n.even?
        i = n / 2
        result *= exp_2(b, i) ** 2
    else
        i = (n - 1) / 2
        result *= b * exp_2(b, i) ** 2
    end

    result
end

# Deep dup
class Array
    def deep_dup
        arr = []
        self.each do |el|
            if el.is_a?(Array)
                arr << el.deep_dup
            else
                arr += [el]
            end
        end

        arr
    end
end

# Fibonacci
def fib_r(n)
    return [1] if n == 1
    return [1, 1] if n == 2

    arr = []
    arr += fib_r(n - 1)
    arr << arr[-1] + arr[-2]

    arr
end

def fib_i(n)
    return [1] if n == 1
    return [1, 1] if n == 2

    arr = [1, 1]
    (3..n).each { arr << arr[-1] + arr[-2] }

    arr
end

# Binary search
def bsearch(array, target)
    pos = 0
    n = array.length
    i = n.even? ? n / 2 : (n - 1) / 2
    if target == array[i] 
        pos = i
    elsif n != 1
        if target < array[i]
            pos = bsearch(array[0...i], target)
        else
            temp_pos = bsearch(array[i+1..-1], target)
            if temp_pos == nil
                pos = nil
            else    
                pos += temp_pos + i + 1
            end
        end
    else
        return nil
    end
    pos
end

# Merge sort
def merge_sort(arr)
    n = arr.length
    return arr if n == 1
    i = n.even? ? n / 2 : (n - 1) / 2
    arr1 = merge_sort(arr[0...i])
    arr2 = merge_sort(arr[i..-1])
    merge([arr1, arr2])
end

def merge(array)
    new_array = []
    n1 = array[0].length
    n2 = array[1].length
    i, j = 0, 0
    while i < n1 || j < n2
        if i == n1
            new_array << array[1][j]
            j += 1
        elsif j == n2
            new_array << array[0][i]
            i += 1
        else
            if array[0][i] < array[1][j]
                new_array << array[0][i]
                i += 1
            else
                new_array << array[1][j]
                j += 1
            end
        end
    end
    new_array
end

# Array subsets
class Array
    def subsets
        return [self] if self.empty?
        subsets = []
        copy = self.dup
        temp = copy.pop
        subsets += copy.subsets
        subsets << [temp]
        subsets[1..-2].each { |arr| subsets << arr + [temp] }
        subsets
    end
end

# Permutations
def permutations(array)
    return [array] if array.empty? || array.length == 1
    return [array, array.reverse] if array.length == 2
    permutations = []
    temp = []
    array.each_with_index do |el, i|
        permutations(array[0...i] + array[i+1..-1]).each do |arr|
            temp << [el] + arr
        end
    end
    permutations += temp
    permutations
end

# Make change
def greedy_make_change(amount, coins = [25, 10, 5, 1])
    return [1] * amount if coins.length == 1
    change = []
    amount.div(coins[0]).times { change << coins[0] }
    amount %= coins[0]
    change += greedy_make_change(amount, coins[1..-1]) if amount != 0
    change
end

def make_better_change(amount, coins = [25, 10, 5, 1])
    best = nil
    coins.each_with_index do |coin, i|
        change = []
        amt = amount
        if amount >= coin
            change << coin
            amt -= coin
            return change if amt == 0
            change += make_better_change(amt, coins[i..-1])
            best = change if !best || change.length <= best.length
        end
    end
    best
end
