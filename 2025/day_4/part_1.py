import sys

diagram = []

file = sys.argv[1]
with open(file + '.txt', 'r') as file:
    for line in file:
        row = list(line.strip())
        diagram.append(row)

max_contact = 4
accessible = 0

def count_surrounding(row_index, col_index):
    start_row = max(row_index - 1, 0)
    end_row = min(row_index + 1, len(diagram) -1)
    start_col = max(col_index - 1, 0)
    end_col = min(col_index + 1, len(diagram[row_index]) - 1)
    adjacent = 0
    for i in range(start_row, end_row + 1):
        for j in range(start_col, end_col + 1):
            if diagram[i][j] == '@':
                adjacent += 1
    return adjacent - 1 # Don't count self

for row_index,row in enumerate(diagram):
    for col_index, col in enumerate(row):
        if col == '.':
            print(col, end="")
            continue
        adjacent = count_surrounding(row_index, col_index)
        if adjacent < max_contact:
            print('x', end="")
            accessible += 1
        else:
            print(col, end="")
    print()

print(accessible)




