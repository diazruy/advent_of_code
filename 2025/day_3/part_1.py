import re
import sys

file = sys.argv[1]
total_joltage = 0

with open(file + '.txt', 'r') as file:
    for line in file:
        batteries = list(line.strip())
        batteries_sorted = sorted(batteries)
        largest_batteries = batteries_sorted[-2:]

        index_largest = batteries.index(largest_batteries[1])
        if index_largest < len(batteries) - 1:
            joltage = ''.join([batteries[index_largest], sorted(batteries[index_largest + 1:]).pop()])
            total_joltage += int(joltage)
        else:
            index_second_largest = batteries.index(largest_batteries[0])
            joltage = ''.join([batteries[index_second_largest], sorted(batteries[index_second_largest + 1:]).pop()])
            total_joltage += int(joltage)

print(total_joltage)
