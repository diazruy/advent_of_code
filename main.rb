require './input_reader'
require 'byebug'

ROUNDS = 10_000

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

  def multiplication?
    operator == :*
  end
end

class Item
  attr_accessor :level
  attr_reader :factors

  def initialize(level)
    @level = level
    @factors = Hash.new(0)
  end

  def adjust_by(operation)
    factors[operation.operand] +=1 if operation.multiplication?

    self.level = operation.perform(level)
  end

  def test?(divisor)
    if factors[divisor] > 0
      factors[divisor] -= 1
    else
      (self.level % divisor).zero?
    end
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
    item.adjust_by(operation)
    target = item.test?(test_factor) ? target_true : target_false
    [target, item]
  end

  def adjusted_worry_level(item)
    operation.perform(item)
  end
end

def print_monkeys(monkeys)
  monkeys.each_with_index do |monkey, index|
    puts "Monkey #{index}: #{monkey.test_factor} -> #{monkey.items.collect(&:level).join(', ')}"
  end
end

monkeys = []

InputReader.each_line(ARGV[0] || 'input.txt') do |line|
  monkey = monkeys.last
  case line
  when /^Monkey/ then monkeys << Monkey.new
  when /Starting items: (?<items>.+)$/
    monkey.items = Regexp.last_match[:items].split(', ').map(&:to_i).collect do |level|
      Item.new(level)
    end
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
  print "\r"
  print round
  monkeys.each do |monkey|
    while (item = monkey.items.shift)
      target_index, item = monkey.test(item)
      monkeys[target_index].items << item
    end
  end
end
print_monkeys(monkeys)

puts monkeys.collect(&:inspections).max(2).reduce(&:*)
