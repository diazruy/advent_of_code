class InputReader
  def self.each_line(file_name = 'input.txt', &block)
    File.open(file_name, 'r') do |file|
      file.each do |line|
        yield line.chomp
      end
    end
  end
end
