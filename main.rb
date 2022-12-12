require './input_reader'
require 'set'
require 'byebug'

MAX_HEIGHT = 9

visible_trees = Set.new

forest = []
max_scenic_score = 0

InputReader.each_line do |line|
  row = line.split("").map(&:to_i)
  forest << row
end

def scenic_score(forest, row, col)
  view_count = Array.new(4, 0)

  current_tree_height = forest[row][col]

  (row - 1).downto(0) do |row_index|
    height = forest[row_index][col]
    next if height.nil?

    view_count[0] += 1 if height <= current_tree_height
    break if height >= current_tree_height
  end

  (row + 1).upto(forest.size - 1) do |row_index|
    height = forest[row_index][col]
    next if height.nil?

    view_count[1] += 1 if height <= current_tree_height
    break if height >= current_tree_height
  end

  (col - 1).downto(0) do |col_index|
    height = forest[row][col_index]
    next if height.nil?

    view_count[2] += 1 if height <= current_tree_height
    break if height >= current_tree_height
  end

  (col + 1).upto(forest[row].size - 1) do |col_index|
    height = forest[row][col_index]
    next if height.nil?

    view_count[3] += 1 if height <= current_tree_height
    break if height >= current_tree_height
  end
  view_count.reduce(&:*)
end

forest.size.times do |row|
  forest[row].size.times do |col|
    max_scenic_score = [max_scenic_score, scenic_score(forest, row, col)].max
  end
end
puts max_scenic_score
