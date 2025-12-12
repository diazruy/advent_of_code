import re
import sys

file = sys.argv[1]
total_joltage = 0
length = 12

def find_largest(options):
    options_sorted = sorted(options, reverse=True)
    largest = options_sorted[0]
    return options.index(largest)
#   0    1    2    3    4    5    6    7    8    9    9   10   11   12   13
# ['9', '8', '7', '6', '5', '4', '3', '2', '1', '1', '1', '1', '1', '1', '1']
#  14   13   12   11   10    9    8    7    6    5    4    3    2    2   1
with open(file + '.txt', 'r') as file:
    for line in file:
        batteries = list(line.strip())
        bank_size = len(batteries)
        joltages = []
        offset = 0

        # what is the largest number from 0 that still has 11 digits after it
        # what is the largest number from offset that still has 10 digits after it
        # what is the largest number from offset that still has 9 digits after it
        # what is the largest number from offset that still has 8 digits after it
        # what is the largest number from offset that still has 7 digits after it
        # what is the largest number from offset that still has 6 digits after it
        # what is the largest number from offset that still has 5 digits after it
        # what is the largest number from offset that still has 4 digits after it
        # what is the largest number from offset that still has 3 digits after it
        # what is the largest number from offset that still has 2 digits after it
        # what is the largest number from offset that still has 1 digits after it
        # what is the largest number from offset

        print(batteries)
        for i in range(0, length):
            digits_after = length - len(joltages)
            range_to_check = batteries[offset:len(batteries) - digits_after]
            print(range_to_check)
            breakpoint()
            if len(range_to_check) > 0:
                next_largest = find_largest(range_to_check)
                joltages.append(batteries[offset + next_largest])
                offset += next_largest + 1

        joltage = ''.join(joltages)
        joltage += ''.join(batteries[offset:offset + length - len(joltage)])
        print(joltage)
        total_joltage += int(joltage)

print(total_joltage)
