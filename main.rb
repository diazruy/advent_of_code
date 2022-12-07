
max_calories = 0
elf_calories = 0

File.open('./input.txt', 'r') do |file|
  file.each do |line|
    if line.strip.length.zero?
      max_calories = [max_calories, elf_calories].max
      elf_calories = 0
    end
    elf_calories += line.to_i
  end
end

puts max_calories
