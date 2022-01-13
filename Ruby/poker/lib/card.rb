class Card
  RANK_TO_STRING = { 
    11 => 'J',
    12 => 'Q',
    13 => 'K',
    14 => 'A',
  }.freeze

  SUIT_TO_SYMBOL = {
    :clubs => "\u2667",
    :diamonds => "\u2662",
    :hearts => "\u2661",
    :spades => "\u2664"
  }

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{@rank <= 10 ? @rank.to_s : RANK_TO_STRING[@rank]}#{SUIT_TO_SYMBOL[@suit]}"
  end
end