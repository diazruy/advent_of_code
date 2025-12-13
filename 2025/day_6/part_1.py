import sys
import re

ranges = []
total_fresh = 0

file = sys.argv[1]
problems = []
operations = []
total = 0

with open(file + '.txt', 'r') as file:
    for line in file:
        values = re.split(r'\s+', line.strip())
        if "+" in line or "*" in line:
            operations = values
        else:
            problems.append(list(map(int, values)))

operand_count = len(problems)

for i in range(len(operations)):
    operation = operations[i]
    result = 0 if operation == '+' else 1
    for j in range(operand_count):
        operand = problems[j][i]
        if operations[i] == '+':
            result += operand
        else:
            result *= operand
    total += result

print(total)





