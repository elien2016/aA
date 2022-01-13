class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack.push(el)
    end

    def pop
        @stack.pop
    end

    def peek
        @stack.last
    end
end

class Queue
    def initialize
        @queue = []
    end
    
    def enqueue(el)
        @queue.push(el)
    end

    def dequeue
        @queue.shift
    end

    def peek
        @queue.first
    end
end

class Map
    def initialize
        @map = Array.new { [] }
    end

    def set(key, value)
        key_exist = false
        @map.each do |pair|
            if pair.first == key
                pair[1] = value
                key_exist = true
                break
            end
        end
        @map.push([key, value]) if key_exist == false
    end

    def get(key)
        @map.each do |pair|
            if pair.first == key
                return pair[1]
            end
        end
        nil
    end

    def delete(key)
        idx = nil
        @map.each_with_index do |pair, i|
            if pair.first == key
                idx = i
            end
        end
        if idx != nil
            @map.delete_at(idx)
        else
            nil
        end
    end

    def show
        print "{ "
        @map.each do |pair|
            print "#{pair.first} => #{pair[1]}, "
        end
        print "}"
    end
end