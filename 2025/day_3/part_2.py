import re
import sys

file = sys.argv[1]
total_joltage = 0
length = 12

def find_largest(options):
    options_sorted = sorted(options, reverse=True)
    largest = options_sorted[0]
    return options.index(largest)

with open(file + '.txt', 'r') as file:
    for line in file:
        batteries = list(line.strip())
        bank_size = len(batteries)
        joltages = []
        offset = 0

        for i in range(0, length):
            digits_after = length - len(joltages) - 1
            range_to_check = batteries[0:len(batteries)-digits_after]
            next_largest = find_largest(range_to_check)
            joltages.append(batteries[next_largest])
            batteries = batteries[next_largest + 1:]

        joltage = ''.join(joltages)
        joltage += ''.join(batteries[offset:offset + length - len(joltage)])
        total_joltage += int(joltage)

print(total_joltage)
