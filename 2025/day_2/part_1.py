import re
import sys

file = sys.argv[1]

with open(file + '.txt', 'r') as file:
    total = 0
    invalid_ids = []
    for line in file:
        ranges = line.split(',')
        for code_range in ranges:
            start, end = map(int, code_range.split('-'))
            for code in range(start, end + 1):
                code_str = str(code)
                code_length = len(code_str)
                code_half = code_length // 2
                if code_str[:code_half] == code_str[code_half:]:
                    invalid_ids.append(code_str)
                    total += code
    print(total)
