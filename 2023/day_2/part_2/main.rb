require './input_reader'

game_regex = /\AGame (?<id>\d+): (?<sets>.*)\z/i

def possible_game?(sets)
  sets.all? do |set|
    cubes = set.split(', ')
    cubes.all? do |cube|
      count, color = cube.split(' ')
      count.to_i <= MAXIMA[color.to_sym]
    end
  end
end

def power(sets)
  max_cubes = Hash.new(0)
  sets.each do |set|
    cubes = set.split(', ').each do |cube|
      count, color = cube.split(' ')
      max_cubes[color] = [max_cubes[color], count.to_i].max
    end
  end
  max_cubes.values.reduce(&:*)
end

sum = 0

InputReader.each_line(File.join(File.dirname(__FILE__), "#{ARGV[0] || 'input'}.txt")) do |line|
  game_match_data = line.match(game_regex)
  sets = game_match_data[:sets].split('; ')
  sum += power(sets)
end
puts sum

