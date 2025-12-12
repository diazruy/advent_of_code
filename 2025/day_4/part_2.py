import sys

diagram = []

file = sys.argv[1]
with open(file + '.txt', 'r') as file:
    for line in file:
        row = list(line.strip())
        diagram.append(row)

MAX_CONTACT = 4

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

def removable():
    accessible = []
    for row_index,row in enumerate(diagram):
        for col_index, col in enumerate(row):
            if col == '.':
                continue
            adjacent = count_surrounding(row_index, col_index)
            if adjacent < MAX_CONTACT:
                accessible.append([row_index, col_index])
    return accessible

count = 0
removable_rolls = []
while(True):
    removable_rolls = removable()
    count += len(removable_rolls)
    for row_index, col_index in removable_rolls:
        diagram[row_index][col_index] = '.'
    if len(removable_rolls) == 0:
        break

print(count)




