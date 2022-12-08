require './input_reader'

def to_range(string)
  min, max = string.split('-')
  (min.to_i..max.to_i)
end

def overlap?(range_1, range_2)
  (range_1.to_a & range_2.to_a).length > 0
end

total = 0

InputReader.each_line do |line|
  ranges = line.split(',').collect { |range_string| to_range(range_string) }
  total += 1 if overlap?(*ranges)
end

puts total
