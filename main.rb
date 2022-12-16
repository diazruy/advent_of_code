require './input_reader'

CRT_WIDTH = 40

cycle = 1
register_x = 1

def render(register_x, cycle)
  if visible?(register_x, cycle)
    print '#'
  else
    print ' '
  end
  puts if (cycle % CRT_WIDTH) == 0
end

def visible?(register_x, cycle)
  sprite(register_x).cover?((cycle - 1) % CRT_WIDTH)
end

def sprite(register_x)
  (register_x - 1)..(register_x + 1)
end

InputReader.each_line(ARGV[0] || 'input.txt') do |line|
  command, increment = line.split(' ')
  increment = increment.to_i

  render(register_x, cycle)
  cycle += 1

  if command ==  'addx'
    render(register_x, cycle)
    cycle += 1
    register_x += increment
  end
end
