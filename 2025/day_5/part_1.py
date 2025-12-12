import sys

ranges = []
total_fresh = 0

def is_fresh(id):
    matching_ranges = [range for range in ranges if id in range]
    return len(matching_ranges) > 0

file = sys.argv[1]
with open(file + '.txt', 'r') as file:
    for line in file:
        if "-" in line:
            range_start, range_end = map(int, line.strip().split('-'))
            ranges.append(range(range_start, range_end + 1))
        elif line.strip() != "":
            if is_fresh(int(line.strip())):
                total_fresh +=1

print(total_fresh)





