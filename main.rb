require './input_reader'

PRIORITIES = ('a'..'z').to_a + ('A'..'Z').to_a

def priority(item)
  PRIORITIES.index(item) + 1
end

def common_item(compartments)
  compartments.reduce(&:&).first
end

total = 0

File.open('input.txt', 'r') do |file|
  file.each_slice(3) do |rucksacks|
    itemized_rucksacks = rucksacks.collect { |rucksack| rucksack.split('').uniq }
    total += priority(common_item(itemized_rucksacks))
  end
end

puts total
