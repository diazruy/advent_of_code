require './input_reader'
require 'byebug'

cycle = 1
register_x = 1

strengths = []

def key_cycle?(cycle)
  ((cycle + 20) % 40).zero?
end

def signal_strength(x, cycle)
  key_cycle?(cycle) ? x * cycle : 0
end

InputReader.each_line(ARGV[0] || 'input.txt') do |line|
  command, increment = line.split(' ')
  increment = increment.to_i

  strengths << signal_strength(register_x, cycle)
  cycle += 1

  if command ==  'addx'
    strengths << signal_strength(register_x, cycle)
    cycle += 1
    register_x += increment
  end
end

puts strengths.sum
