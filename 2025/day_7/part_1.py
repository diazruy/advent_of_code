import sys
import re
file = sys.argv[1]

beams = set()
splits = 0

with open(file + '.txt', 'r') as file:
    for line in file:
        if 'S' in line:
            index = line.index('S')
            beams.add(index)
        else:
            if '^' in line:
                matches = re.finditer(r"\^", line.strip())
                for match in matches:
                    match_index = match.start()
                    if match_index in beams:
                        splits += 1
                        beams.remove(match_index)
                        beams.add(match_index - 1)
                        beams.add(match_index + 1)
print(splits)

