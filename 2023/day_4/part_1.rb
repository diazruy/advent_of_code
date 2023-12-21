require './input_reader'
require 'byebug'

sum = 0
InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  numbers = line.split(':').last
  winning_numbers, my_numbers = numbers.split('|').collect { |list| list.split(' ') }
  matched_numbers = winning_numbers & my_numbers
  sum += 2 ** (matched_numbers.size - 1) if matched_numbers.size.positive?
end

puts sum
