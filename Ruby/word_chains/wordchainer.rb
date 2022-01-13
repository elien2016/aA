class WordChainer
    def initialize(dictionary_file_name = "dictionary.txt")
        words = File.readlines(dictionary_file_name).map(&:chomp)
        @dictionary = Set.new(words)
    end

    def adjacent_words(word)
        length = word.length
        arr = @dictionary.select { |wrd| wrd.length == length }
        arr = arr.select do |wrd|
            ct = 0
            wrd.each_char.with_index do |char, i|
                ct += 1 if char == word[i]
            end
            ct == length - 1
        end
        arr
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words = { source => nil }
        while !@current_words.empty?
            explore_current_words
        end
        puts build_path(target)
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adjacent_word|
                next if @all_seen_words.include?(adjacent_word)
                new_current_words << adjacent_word
                @all_seen_words[adjacent_word] = current_word
            end
        end
        @current_words = new_current_words
    end

    def build_path(target)
        previous = target
        path = [target]
        until previous == nil
            previous = @all_seen_words.values_at(previous).first
            path << previous
        end
        path.reverse[1..-1]
    end

end