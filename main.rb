
elf_calories = 0
calories_by_elf = []

File.open('./input.txt', 'r') do |file|
  file.each do |line|
    if line.strip.length.zero?
      calories_by_elf << elf_calories
      elf_calories = 0
    end
    elf_calories += line.to_i
  end
end

puts calories_by_elf.sort.last(3).sum
