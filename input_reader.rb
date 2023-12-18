class InputReader
  def self.each_line(path = File.join(File.dirname(caller.first), "input.txt"), &block)
    File.open(path, 'r') do |file|
      file.each do |line|
        yield line.chomp
      end
    end
  end
end
