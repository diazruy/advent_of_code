require 'byebug'
require './input_reader'

module AoC
  class Directory
    attr_reader :name, :directories, :files
    def initialize(name)
      @name = name
      @directories = []
      @files = []
    end
  end

  class File
    attr_reader :name, :size
    def initialize(name, size)
      @name = name
      @size = size
    end
  end

  class OutputParser
    attr_accessor :current_path, :file_system

    def initialize
      @current_path = []
      @file_system = Hash.new(0)
    end

    def process_line(line)
      if command?(line)
        command, path = parse_command(line)
        cd(path) if command == 'cd'
      elsif file?(line)
        size = line.split(' ').first.to_i
        current_path.size.times do |index|
          file_system[current_path[0..index].join(".")] += size
        end
      end
    end

    def sum_of_paths_less_than(size)
      file_system.values.find_all { |value| value <= size }.sum
    end

    private

    def command?(line)
      line.start_with? '$'
    end

    def parse_command(line)
      line.split(' ')[1..]
    end

    def file?(line)
      line =~ /\A\d+/
    end

    def cd(path)
      case path
      when "/" then self.current_path = [path]
      when ".." then current_path.pop
      else current_path.push(path)
      end
    end
  end
end


parser = AoC::OutputParser.new

InputReader.each_line do |line|
  parser.process_line(line)
end
puts parser.sum_of_paths_less_than(100_000)
