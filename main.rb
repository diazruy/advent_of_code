require './input_reader'
require 'byebug'

ROUNDS = 20

class Operation
  attr_reader :operator, :operand

  def initialize(operator, operand)
    @operator = operator
    @operand = operand
  end

  def perform(item)
    operand = self.operand == 'old' ? item : self.operand.to_i
    item.send(operator, operand)
  end
end

class Monkey
  attr_accessor :items, :test_factor, :target_true, :target_false, :operation, :inspections
  def initialize
    @items = []
    @inspections = 0
  end

  def test(item)
    @inspections += 1
    item = adjusted_worry_level(item)
    target = (item % test_factor) == 0 ? target_true : target_false
    [target, item]
  end

  def adjusted_worry_level(item)
    operation.perform(item) / 3
  end
end

def print_monkeys(monkeys)
  monkeys.each_with_index do |monkey, index|
    puts "Monkey #{index}: #{monkey.test_factor} -> #{monkey.items.join(', ')}"
  end
end

monkeys = []

InputReader.each_line(ARGV[0] || 'input.txt') do |line|
  monkey = monkeys.last
  case line
  when /^Monkey/ then monkeys << Monkey.new
  when /Starting items: (?<items>.+)$/
    monkey.items = Regexp.last_match[:items].split(', ').map(&:to_i)
  when /Operation: new = old (?<operator>.) (?<operand>.+)$/
    monkey.operation = Operation.new(
      Regexp.last_match[:operator].to_sym,
      Regexp.last_match[:operand]
    )
  when /Test.* (?<test_factor>\d+)/
    monkey.test_factor = Regexp.last_match[:test_factor].to_i
  when /If true.*(?<target>\d+)/
    monkey.target_true = Regexp.last_match[:target].to_i
  when /If false.*(?<target>\d+)/
    monkey.target_false = Regexp.last_match[:target].to_i
  end
end


ROUNDS.times do |round|
  monkeys.each do |monkey|
    while (item = monkey.items.shift)
      target_index, item = monkey.test(item)
      monkeys[target_index].items << item
    end
  end
end

puts monkeys.collect(&:inspections).max(2).reduce(&:*)
