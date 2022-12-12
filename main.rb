require './input_reader'
require 'set'

MAX_HEIGHT = 9

visible_trees = Set.new

forest = []
total_visible = 0

def tallest_trees(row)
  max_height = -1
  visible = []
  row.each_with_index do |height, col_index|
    if height > max_height
      visible << col_index
      max_height = height
      break if height == MAX_HEIGHT
    end
  end
  visible
end

row_index = 0
InputReader.each_line do |line|
  row = line.split("").map(&:to_i)
  forest << row
  tallest_trees(row).each do |col|
    visible_trees << [row_index, col]
  end
  tallest_trees(row.reverse).each do |col|
    visible_trees << [row_index, row.size - col - 1]
  end
  row_index += 1
end

forest.transpose.each_with_index do |row, row_index|
  tallest_trees(row).each do |col|
    visible_trees << [col, row_index]
  end
  tallest_trees(row.reverse).each do |col|
    visible_trees << [row.size - col - 1, row_index]
  end
end

puts visible_trees.size
