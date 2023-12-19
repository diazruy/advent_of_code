class InputReader
  def self.each_line(path = File.join(File.dirname(caller.first), "input.txt"), &block)
    File.open(path, 'r') do |file|
      file.each.with_index do |line, index|
        yield line.chomp, index
      end
    end
  end
end
