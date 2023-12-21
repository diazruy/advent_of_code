require './input_reader'
require 'byebug'

def differences(sequence)
  (sequence.size - 1).times.collect do |index|
    sequence[index + 1] - sequence[index]
  end
end

def next_value(sequence)
  differences = []
  differences << differences(sequence)
  while(!differences.last.all?(&:zero?))
    differences << differences(differences.last)
  end
  differences.sum(0, &:last) + sequence.last
end

sum = 0
InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  sequence = line.split(' ').map(&:to_i)
  value = next_value(sequence)
  sum += value
end

puts sum
