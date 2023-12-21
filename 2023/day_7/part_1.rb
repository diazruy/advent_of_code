require './input_reader'
require 'byebug'

CARDS = %w[ 2 3 4 5 6 7 8 9 T J Q K A ]
HANDS = %i[
  high_card
  one_pair
  two_pair
  three_of_a_kind
  full_house
  four_of_a_kind
  five_of_a_kind
]

def hand_type(cards)
  card_counts = cards.split('').tally
  if card_counts.values.any? { |count| count == 5 }
    :five_of_a_kind
  elsif card_counts.values.any? { |count| count == 4 }
    :four_of_a_kind
  elsif card_counts.values.any? { |count| count == 3 } && card_counts.values.any? { |count| count == 2 }
    :full_house
  elsif card_counts.values.any? { |count| count == 3 }
    :three_of_a_kind
  elsif card_counts.values.find_all { |count| count == 2 }.size == 2
    :two_pair
  elsif card_counts.values.any? { |count| count == 2 }
    :one_pair
  else
    :high_card
  end
end

def compare_hands(hand_a, hand_b)
  cards_a = hand_a[:cards].split('')
  cards_b = hand_b[:cards].split('')
  comparison = nil
  0.upto(cards_a.size) do |index|
    comparison = CARDS.index(cards_a[index]) <=> CARDS.index(cards_b[index])
    break unless comparison.zero?
  end
  comparison
end


hands = []
InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  cards, bid = line.split(' ')
  bid = bid.to_i
  hands << {cards:, bid:, hand_type: hand_type(cards)}
end

sorted_hands = hands.sort do |hand_a, hand_b|
  comparison = HANDS.index(hand_a[:hand_type]) <=> HANDS.index(hand_b[:hand_type])
  if comparison.zero?
    compare_hands(hand_a, hand_b)
  else
    comparison
  end
end

winnings = 0
sorted_hands.each.with_index(1) do |hand, index|
  winnings += hand[:bid] * index
end

puts winnings
