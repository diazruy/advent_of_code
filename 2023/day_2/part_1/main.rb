require './input_reader'

game_regex = /\AGame (?<id>\d+): (?<sets>.*)\z/i

MAXIMA = {
  red: 12 ,
  green: 13,
  blue: 14
}


def possible_game?(sets)
  sets.all? do |set|
    cubes = set.split(', ')
    cubes.all? do |cube|
      count, color = cube.split(' ')
      count.to_i <= MAXIMA[color.to_sym]
    end
  end
end

sum = 0

InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  game_match_data = line.match(game_regex)
  sets = game_match_data[:sets].split('; ')
  sum += game_match_data[:id].to_i if possible_game?(sets)
end
puts sum

