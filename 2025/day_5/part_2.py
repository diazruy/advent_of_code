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
        else:
            break

def is_overlapping(range_1, range_2):
    return range_1[0] <= range_2[-1] and range_2[0] <= range_1[-1]

def is_contained(range_1, range_2):
    return range_1[0] <= range_2[0] and range_1[-1] >= range_2[-1]

def are_mergeable(range_1, range_2):
    return is_overlapping(range_1, range_2) or is_contained(range_1, range_2) or is_contained(range_2, range_1)

def merge_ranges(range_1, range_2):
    return range(min(range_1[0], range_2[0]), max(range_1[-1], range_2[-1]) + 1)

def reduce_ranges(ranges):
    unique_ranges = []

    for id_range in ranges:
        overlapping = [unique_range for unique_range in unique_ranges if are_mergeable(id_range, unique_range) ]
        for overlap in overlapping:
            index = unique_ranges.index(overlap)
            unique_ranges[index] = merge_ranges(overlap, id_range)
        if len(overlapping) == 0:
            unique_ranges.append(id_range)
    return unique_ranges

while True:
    previous_size = len(ranges)
    ranges = reduce_ranges(ranges)
    if len(ranges) == previous_size:
        break

for range in ranges:
    total_fresh += (range[-1] + 1) - range[0]

print(total_fresh)





