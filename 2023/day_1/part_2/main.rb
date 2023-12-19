require './input_reader'
require 'byebug'

sum = 0
DIGITS = %w[
  one
  two
  three
  four
  five
  six
  seven
  eight
  nine
]

reversed_digits = DIGITS.map(&:reverse)
regex_digits = /(?<digit>\d|#{DIGITS.join('|')})/i
regex_reversed = /(?<digit>\d|#{reversed_digits.join('|')})/i

def to_i(digit_string)
  if (number = digit_string.to_i) > 0
    number
  else
    DIGITS.index(digit_string) + 1
  end
end

InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  first_digit_string = line.match(regex_digits)[:digit]
  first_digit = to_i(first_digit_string)
  last_digit_string = line.reverse.match(regex_reversed)[:digit].reverse
  last_digit = to_i(last_digit_string)

  number = [first_digit, last_digit].join.to_i
  sum += number
end
puts sum

