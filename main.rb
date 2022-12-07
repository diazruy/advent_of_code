require 'byebug'
require './input_reader'

PRIORITIES = ('a'..'z').to_a + ('A'..'Z').to_a

def priority(item)
  PRIORITIES.index(item) + 1
end

total = 0

def compartments(items)
  items.each_slice(items.length / 2).to_a
end

def common_item(compartments)
  compartments.reduce(&:&).first
end

InputReader.each_line do |line|
  items = line.split('')
  total += priority(common_item(compartments(items)))
end

puts total
