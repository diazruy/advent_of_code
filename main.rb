require './input_reader'

def to_range(string)
  min, max = string.split('-')
  (min.to_i..max.to_i)
end

def contained?(range_1, range_2)
  range_1.cover?(range_2) || range_2.cover?(range_1)
end

total = 0

InputReader.each_line do |line|
  ranges = line.split(',').collect { |range_string| to_range(range_string) }
  total += 1 if contained?(*ranges)
end

puts total
