load 'compare_hands.rb'
load 'card.rb'

hand1 = [Card.new(11, :spades),
  Card.new(1, :hearts),
  Card.new(3, :clubs),
  Card.new(8, :diamonds),
  Card.new(5, :clubs)]
hand2 = hand1.reverse
hands = [hand1, hand2]
hand_cards = Hand.make_hand_cards(hands)
arrays = hand_cards.values

high_card1 = Hand.new([Card.new(13, :spades),
  Card.new(12, :hearts),
  Card.new(7, :clubs),
  Card.new(8, :diamonds),
  Card.new(5, :clubs)])
high_card2 = Hand.new([Card.new(9, :spades),
  Card.new(12, :hearts),
  Card.new(7, :clubs),
  Card.new(8, :diamonds),
  Card.new(5, :clubs)])
high_card3 = Hand.new([Card.new(13, :spades),
  Card.new(12, :hearts),
  Card.new(7, :clubs),
  Card.new(6, :diamonds),
  Card.new(5, :clubs)])
hands = [high_card1, high_card2, high_card3]
Hand.highest(:high_card, hands)
Hand.winner(hands)

one_pair1 = Hand.new([Card.new(10, :spades),
  Card.new(10, :hearts),
  Card.new(7, :clubs),
  Card.new(8, :diamonds),
  Card.new(5, :clubs)])
one_pair2 = Hand.new([Card.new(6, :spades),
  Card.new(6, :hearts),
  Card.new(12, :clubs),
  Card.new(11, :diamonds),
  Card.new(5, :clubs)])
one_pair3 = Hand.new([Card.new(10, :spades),
  Card.new(7, :hearts),
  Card.new(8, :clubs),
  Card.new(10, :diamonds),
  Card.new(3, :clubs)])
hands = [one_pair1, one_pair2, one_pair3]
Hand.winner(hands)

two_pair1 = Hand.new([Card.new(12, :spades),
  Card.new(12, :hearts),
  Card.new(3, :clubs),
  Card.new(3, :diamonds),
  Card.new(14, :clubs)])
two_pair2 = Hand.new([Card.new(12, :spades),
  Card.new(12, :hearts),
  Card.new(3, :clubs),
  Card.new(3, :diamonds),
  Card.new(14, :clubs)])
two_pair3 = Hand.new([Card.new(11, :spades),
  Card.new(3, :hearts),
  Card.new(2, :clubs),
  Card.new(11, :diamonds),
  Card.new(2, :clubs)])
two_pair4 = Hand.new([Card.new(6, :spades),
  Card.new(6, :hearts),
  Card.new(8, :clubs),
  Card.new(8, :diamonds),
  Card.new(4, :clubs)])
two_pair5 = Hand.new([Card.new(11, :spades),
  Card.new(3, :hearts),
  Card.new(4, :clubs),
  Card.new(11, :diamonds),
  Card.new(3, :clubs)])
two_pair6 = Hand.new([Card.new(11, :spades),
  Card.new(3, :hearts),
  Card.new(2, :clubs),
  Card.new(11, :diamonds),
  Card.new(3, :clubs)])
hands = [two_pair1, two_pair2, two_pair3, two_pair4]
hands = [two_pair1, two_pair2, two_pair3, two_pair5] # last one
hands = [two_pair1, two_pair2, two_pair3, two_pair6] # first and last
Hand.winner(hands)

three_oak1 = Hand.new([Card.new(11, :spades),
  Card.new(11, :hearts),
  Card.new(2, :clubs),
  Card.new(11, :diamonds),
  Card.new(3, :clubs)])
three_oak2 = Hand.new([Card.new(9, :spades),
  Card.new(9, :hearts),
  Card.new(2, :clubs),
  Card.new(9, :diamonds),
  Card.new(3, :clubs)])
hands = [three_oak1, three_oak2]
Hand.winner(hands) # first

full_house1 = Hand.new([Card.new(11, :spades),
  Card.new(11, :hearts),
  Card.new(2, :clubs),
  Card.new(11, :diamonds),
  Card.new(2, :clubs)])
full_house2 = Hand.new([Card.new(6, :spades),
  Card.new(6, :hearts),
  Card.new(13, :clubs),
  Card.new(6, :diamonds),
  Card.new(13, :clubs)])
hands = [full_house1, full_house2]
Hand.winner(hands) # first

four_oak1 = Hand.new([Card.new(4, :spades),
  Card.new(4, :hearts),
  Card.new(4, :clubs),
  Card.new(4, :diamonds),
  Card.new(2, :clubs)])
four_oak2 = Hand.new([Card.new(6, :spades),
  Card.new(6, :hearts),
  Card.new(6, :clubs),
  Card.new(6, :diamonds),
  Card.new(13, :clubs)])
hands = [four_oak1, four_oak2]
Hand.winner(hands) # second

straight1 = Hand.new([Card.new(6, :spades),
  Card.new(7, :hearts),
  Card.new(8, :clubs),
  Card.new(9, :diamonds),
  Card.new(10, :clubs)])
straight2 = Hand.new([Card.new(4, :spades),
  Card.new(5, :hearts),
  Card.new(6, :clubs),
  Card.new(7, :diamonds),
  Card.new(8, :clubs)])
straight3 = Hand.new([Card.new(6, :spades),
  Card.new(7, :hearts),
  Card.new(8, :clubs),
  Card.new(9, :diamonds),
  Card.new(10, :clubs)])
hands = [straight1, straight2, straight3]
Hand.winner(hands) # first and third