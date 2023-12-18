require './input_reader'
require 'byebug'

sum = 0
InputReader.each_line("2023/day_1/#{ARGV[0] || 'input'}.txt") do |line|
  first_digit = line[line.index(/\d/)].to_i
  last_digit = line[-1 - line.reverse.index(/\d/)].to_i
  number = [first_digit, last_digit].join.to_i
  sum += number
end
puts sum

