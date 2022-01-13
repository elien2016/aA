module CompareHands
  def highest(hand, hands)
    hand_cards = make_hand_cards(hands)
    arrays = hand_cards.values

    case hand
    when :high_card, :flush
      return highest_high_card_or_flush_hands(arrays, hand_cards)
    when :one_pair
      return highest_one_pair_hands(arrays, hand_cards)
    when :two_pair
      return highest_two_pair_hands(arrays, hand_cards)
    when :three_of_a_kind, :full_house, :four_of_a_kind
      return highest_of_a_kind_or_full_house_hands(arrays, hand_cards)
    when :straight, :straight_flush
      return highest_straight_or_straight_flush_hands(arrays, hand_cards)
    end
  end

  def make_hand_cards(hands)
    hand_cards = {}
    hands.each { |h| hand_cards[h] = h.cards.map { |card| card.rank }.sort.reverse }
    hand_cards
  end

  def highest_high_card_or_flush_hands(arrays, hand_cards)
    highest_array = highest_array(arrays)
    get_highest_hands(highest_array, hand_cards)
  end

  def highest_array(arrays)
    arrays_copy = [*arrays]
    i = 0
    while i < arrays.length
      arrays.each do |arr|
        arrays_copy.delete(arr) if (arrays[i] <=> arr) == 1
      end
      i += 1
      break if arrays_copy.length == 1
    end
    arrays_copy[0]
  end

  def get_highest_hands(highest_arr, hand_cards)
    return hand_cards.map { |hand, arr| arr == highest_arr ? hand : nil }.compact
  end
  
  def highest_one_pair_hands(arrays, hand_cards)
    count = count(arrays)
    pair_values = count.map { |hash| hash.key(2) }
    pair_val_max = pair_values.max
    indices = pair_values.each_index.select { |i| pair_values[i] == pair_val_max }
    further_compare_and_return(indices, arrays, hand_cards)
  end

  def further_compare_and_return(indices, arrays, hand_cards)
    if indices.length == 1
      return [hand_cards.key(arrays[indices.first])]
    else
      highest_arrays = [arrays[indices[0]], arrays[indices[1]]]
      highest_arrays_count = count(highest_arrays)
      single_values = highest_arrays_count.map { |hash| hash.keys.select { |k| hash[k] == 1 } }

      case single_values[0] <=> single_values[1]
      when 1
        return [hand_cards.key(arrays[indices[0]])]
      when -1
        return [hand_cards.key(arrays[indices[1]])]
      when 0
        return hand_cards.keys.select { |hand| highest_arrays.include?(hand_cards[hand]) }
      end
    end
  end

  def count(arrays)
    count = []
    arrays.each do |arr|
      hash = Hash.new(0)
      arr.each { |num| hash[num] += 1 }
      count << hash
    end
    count
  end

  def highest_two_pair_hands(arrays, hand_cards)
    count = count(arrays)
    two_pairs = count.map { |hash| hash.keys.select { |k| hash[k] == 2 }.sort.reverse }
    highest_two_pair = highest_array(two_pairs)
    indices = two_pairs.each_index.select { |i| two_pairs[i] == highest_two_pair }
    further_compare_and_return(indices, arrays, hand_cards)
  end

  def highest_of_a_kind_or_full_house_hands(arrays, hand_cards)
    count = count(arrays)
    max_freq = count[0].values.max
    highest_ranks = count.map { |hash| hash.key(max_freq) }
    highest_idx = highest_ranks.each_with_index.max[1]
    return [hand_cards.key(arrays[highest_idx])]
  end

  def highest_straight_or_straight_flush_hands(arrays, hand_cards)
    highest_val = arrays.map { |arr| arr.last }.max
    highest_array = nil
    arrays.each do |arr|
      if arr.last == highest_val
        highest_array = arr
        break
      end
    end
    get_highest_hands(highest_array, hand_cards)
  end
end