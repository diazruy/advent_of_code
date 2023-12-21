require './input_reader'
require 'byebug'

durations = []
distances = []

def quantities(line)
  line.split(':').last.split(' ').map(&:to_i)
end

InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  durations = quantities(line) if line =~ /Time/
  distances = quantities(line) if line =~ /Distance/
end

result = 1
durations.each_with_index do |race_duration, index|
  distance_to_beat = distances[index]
  winning_times = 0
  0.upto(race_duration) do |hold_time|
    travel_time = race_duration - hold_time
    distance = travel_time * hold_time
    winning_times += 1 if distance > distance_to_beat
  end
  result *= winning_times
end
puts result
