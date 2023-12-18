require './input_reader'

CHARS = ('a'..'z').to_a

map = []
steps = 0

visited_nodes = []
unvisited_nodes = []

distances = Hash.new { Float::INFINITY }

Position = Stuct.new(:row, :col, :height)

def height(char)
  char = case char
         when 'S' then 'a'
         when 'E' then 'z'
         else char
         end
  CHARS.index(char)
end

start = finish = nil

def reachable_nodes(node, map)
  nodes = []
  (-1..1).each do |row_offset|
    (-1..1).each do |col_offset|
      current_node = map[row][col]
      next unless current_node

      nodes << current_node if reachable?(node, current_node)

    end
  end
end

def reachable?(from_node, to_node)
  (to_node.height - from_node.height) < -1
end

row = 0
InputReader.each_line(ARGV[0] || 'input.txt') do |line|
  map << line.split('').collect.each_with_index do |char, col|
    Position.new(row, col, height(char)).tap do |node|
      case char
      when 'S' then start = node
      when 'E' then finish = finish
      end

      unvisited_nodes << node
    end
  end
  row += 1
end

def nearest(nodes, distances)
  min_distance = nodes.collect do |node|
    distances[node]
  end.min
  nodes.index { |node| distances[node] == min_distance }
end

distances[start] = 0

while unvisited_nodes.size > 0
  node_set = unvisited_nodes & reachable_nodes(start, map)
  nearest_node = nearest(node_set, distances)

end
