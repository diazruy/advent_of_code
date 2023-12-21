require './input_reader'
require 'byebug'

seeds = nil
maps = []

InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  next if line.length.zero?

  if line.start_with?('seeds:')
    seeds = line.split(': ').last.split(' ').map(&:to_i)
    next
  end

  if line.start_with?(/[a-z]/)
    maps << {}
  else
    destination_range_start, source_range_start, length = line.split(' ').map(&:to_i)
    range = source_range_start..(source_range_start + length)
    maps.last[range] = destination_range_start
  end
end

min_location = Float::INFINITY
seeds.each do |seed|
  location = maps.inject(seed) do |value, map|
    range, destination_range_start = map.find do |range, destination_range_start|
      range.cover? value
    end
    if range
      offset = value - range.begin
      destination_range_start + offset
    else
      value
    end
  end
  min_location = [min_location, location].min
end

puts min_location
