require './input_reader'
require 'strscan'
require 'byebug'

symbol_positions = []
InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  scanner = StringScanner.new(line)
  indexes = []
  while !scanner.eos?
    if scanner.scan(/[\.\d]+/) && !scanner.eos?
      indexes << scanner.pos
    end
    scanner.pos += 1 unless scanner.eos?
  end
  symbol_positions << indexes
end

sum = 0
InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line, index|
  scanner = StringScanner.new(line)
  while !scanner.eos?
    if scanner.scan_until(/\d+/)
      min_index = [scanner.pos - scanner.matched.length - 1, 0].max
      max_index = [scanner.pos, line.size].min
      range = min_index..max_index
      is_part = [-1, 0, 1].any? do |offset|
        next if (index + offset).negative?

        symbol_positions[index + offset]&.any? { |pos| range.cover?(pos) }
      end
      sum += scanner.matched.to_i if is_part
    end
    scanner.pos += 1 unless scanner.eos?
  end
end

puts sum

