require './input_reader'

WINDOW_SIZE = 4

def start_of_packet_marker?(window)
  window.split('').uniq.length == WINDOW_SIZE
end

InputReader.each_line do |line|
  (line.length - WINDOW_SIZE).times do |index|
    to = index + WINDOW_SIZE
    window = line[index...to]
    if start_of_packet_marker?(window)
      puts to
      exit
    end
  end
end
