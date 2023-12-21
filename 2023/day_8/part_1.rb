require './input_reader'
require 'byebug'

instructions = nil
network = {}
index = 0
MAP_REGEX = /\A(?<node>.+) = \((?<left>.+), (?<right>.+)\)\z/

InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  case index
  when 0
    instructions = line.split('')
  when 1
    # skip
  else
    match_data = MAP_REGEX.match(line)
    network[match_data[:node]] = [match_data[:left], match_data[:right]]
  end
  index += 1
end

steps = 0
current_node = 'AAA'
while current_node != 'ZZZ' do
  instruction = instructions.first
  current_node = network[current_node][instruction == 'L' ? 0 : 1]
  instructions.rotate!
  steps += 1
end

pp steps
