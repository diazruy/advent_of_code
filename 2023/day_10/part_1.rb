require './input_reader'
require 'byebug'

CONNECTIONS = {
  up: %w[| 7 F],
  down: %w[| L J],
  left: %w[- L F],
  right: %w[- J 7]
}

CONNS = {
  '|' => %i[up down],
  '7' => %i[left down],
  'J' => %i[up left],
  'L' => %i[up right],
  'F' => %i[right down],
  '-' => %i[left right],
}

map = []
start = nil
row = 0
InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  map << line.split('')
  if line.index('S')
    start = [row, line.index('S')]
  end
  row += 1
end

def adjacent_tiles(map, tile)
  row, col = tile
  {
    left: (map[row][col - 1] unless col.zero?),
    right: map[row][col + 1],
    up: (map[row - 1]&.[](col) unless row.zero?),
    down: map[row + 1]&.[](col),
  }.compact
end


def tile_towards(direction, tile)
  row, col = tile
  case direction
  when :up then [row - 1, col]
  when :down then [row + 1, col]
  when :left then [row, col - 1]
  when :right then [row, col + 1]
  end
end

def tile_at(coords, map)
  map[coords.first][coords.last]
end

def connects?(tile, direction)
  CONNECTIONS[direction].include?(tile) || tile == 'S'
end

def first_tile(map, current_tile, previous_tile)
  direction, tile = adjacent_tiles(map, current_tile).find do |direction, tile|
    connects?(tile, direction) && tile_towards(direction, current_tile) != previous_tile
  end
  tile_towards(direction, current_tile)
end

loop_length = 1
current_tile = start.dup
previous_tile = start
current_tile = first_tile(map, start, previous_tile)
loop do
  loop_length += 1
  next_directions = CONNS[tile_at(current_tile, map)]
  next_tiles = next_directions.collect { |direction| tile_towards(direction, current_tile) }
  next_tile = next_tiles.find { |tile| tile != previous_tile }
  break if next_tile == start
  previous_tile, current_tile = [current_tile, next_tile]
end
pp loop_length / 2

