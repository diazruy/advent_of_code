require './input_reader'

STACK_COUNT = 9
STACK_LINE_REGEX = /\[/
MOVE_LINE_REGEX = /\Amove (?<amount>\d+) from (?<from>\d+) to (?<to>\d+)/

stacks = []
STACK_COUNT.times { stacks << [] }

def stack_line?(line)
  line =~ STACK_LINE_REGEX
end

def move_line?(line)
  line =~ MOVE_LINE_REGEX
end

def build_stacks(stacks, line)
  STACK_COUNT.times do |stack_index|
    item = line[stack_index * 4 + 1].strip
    stacks[stack_index] << item if item.length > 0
  end
end

def perform_move(stacks, line)
  match_data = MOVE_LINE_REGEX.match line
  match_data[:amount].to_i.times do
    source = match_data[:from].to_i - 1
    destination = match_data[:to].to_i - 1
    item = stacks[source].shift
    stacks[destination].unshift(item)
  end
end

InputReader.each_line do |line|
  build_stacks(stacks, line) if stack_line?(line)
  perform_move(stacks, line) if move_line?(line)
end

stacks.each do |stack|
  print stack[0]
end
puts
