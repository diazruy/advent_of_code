import re
import sys
import math

file = sys.argv[1]
break_at = int(sys.argv[2]) if len(sys.argv) > 2 else -1

counter = 0
regex = re.compile(r'^(?P<direction>[LR])(?P<steps>\d+)$')
current_position = 50
index = 0

with open(file + '.txt', 'r') as file:
    for line in file:
        match = regex.match(line)
        if match:
            direction = match.group('direction')
            steps = int(match.group('steps'))

            full_rotations = steps // 100
            counter += full_rotations

            steps = steps % 100

            previous_position = current_position

            if match.group('direction') == 'L':
                current_position -= steps
            else:
                current_position += steps

            if current_position > 99:
                current_position -= 100
                if previous_position != 0:
                    counter += 1
            elif current_position < 0:
                current_position = 100 + current_position
                if previous_position != 0:
                    counter += 1
            elif previous_position != 0 and current_position == 0:
                counter += 1

            print(line.strip(), 'prev', previous_position, 'current', current_position, 'full_rotations', full_rotations, 'counter', counter)
        index += 1
        if index == break_at:
           break
print(counter)
