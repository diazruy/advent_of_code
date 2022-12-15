require './input_reader'
require 'set'
require 'byebug'

Position = Struct.new(:x, :y, keyword_init: true)

positions_visited = Set.new

head = Position.new(x: 0, y: 0)
tail = Position.new(x: 0, y: 0)

positions_visited << tail.dup

def move_head(head, direction)
  case direction
  when 'R' then head.x += 1
  when 'L' then head.x -= 1
  when 'U' then head.y += 1
  when 'D' then head.y -= 1
  end
end

def move_tail(head, tail)
  delta_x = head.x - tail.x
  delta_y = head.y - tail.y

  offset_x = delta_x.positive? ? 1 : -1
  offset_y = delta_y.positive? ? 1 : -1

  if head.x == tail.x && delta_y.abs > 1
    tail.y += offset_y
  elsif head.y == tail.y && delta_x.abs > 1
    tail.x += offset_x
  elsif delta_x.abs > 1 || delta_y.abs > 1
    tail.x += offset_x
    tail.y += offset_y
  end
end

def render(head, tail)
  max_x = [head.x, tail.x, 20].max
  min_x = [head.x, tail.x, 0].min
  max_y = [head.y, tail.y, 20].max
  min_y = [head.y, tail.y, 0].min
  max_y.downto(min_y) do |y|
    output = []
    min_x.upto(max_x) do |x|
      output << if head.x == x && head.y == y then 'H'
                elsif tail.x == x && tail.y == y then 'T'
                elsif x == 0 && y == 0 then 's'
                else '.'
                end
    end
    puts output.join
  end
  puts
end

InputReader.each_line do |line|
  direction, count = line.split(' ')
  count.to_i.times do
    move_head(head, direction)
    move_tail(head, tail)
    positions_visited << tail.dup
  end
end

puts positions_visited.size
