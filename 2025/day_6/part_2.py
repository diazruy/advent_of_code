import sys
import re

file = sys.argv[1]
total = 0

digits = []
operations = ''
operation_regex = re.compile(r'(\*|\+)')

with open(file + '.txt', 'r') as file:
    for line in file:
        if "+" in line or "*" in line:
            operations = line.rstrip("\n")
        else:
            digits.append(line.rstrip("\n"))

total_problems = len(re.split(r'\s+', operations.strip()))

def problem_width(index):
    match = operation_regex.search(operations, index + 1)
    next_operation_index = -1
    if match:
        next_operation_index = operations.index(match[1], index + 1)
    else:
        next_operation_index = len(operations) + 1
    return next_operation_index - index - 1

def get_operands(index, width):
    operands = [''] * width
    for digit_row in digits:
        row_digits = digit_row[index:index + width]
        for operand_index, digit in enumerate(row_digits):
            operands[operand_index] += digit
    operands = [int(operand.strip()) for operand in operands]
    return operands

column = 0
for i in range(total_problems):
    operation = operations[column]
    width = problem_width(column)
    operands = get_operands(column, width)

    result = 0 if operation == '+' else 1

    for operand in operands:
        if operation == '+':
            result += operand
        else:
            result *= operand
    total += result
    column += width + 1

print(total)





