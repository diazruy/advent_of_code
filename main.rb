require './input_reader'

MARKER_SIZE = 14

def marker?(window)
  window.split('').uniq.length == MARKER_SIZE
end

InputReader.each_line do |line|
  (line.length - MARKER_SIZE).times do |index|
    to = index + MARKER_SIZE
    window = line[index...to]
    if marker?(window)
      puts to
      exit
    end
  end
end
