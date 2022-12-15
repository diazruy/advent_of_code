require './input_reader'
require 'set'
require 'byebug'

Position = Struct.new(:x, :y, keyword_init: true)

positions_visited = Set.new

knots = 10.times.collect do
  Position.new(x: 0, y: 0)
end

positions_visited << knots.last.dup

def move_head(head, direction)
  case direction
  when 'R' then head.x += 1
  when 'L' then head.x -= 1
  when 'U' then head.y += 1
  when 'D' then head.y -= 1
  end
end

def move_knot(head, tail)
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

InputReader.each_line do |line|
  direction, count = line.split(' ')
  count.to_i.times do
    move_head(knots.first, direction)
    9.times do |index|
      move_knot(knots[index], knots[index + 1])
    end
    positions_visited << knots.last.dup
  end
end

puts positions_visited.size
