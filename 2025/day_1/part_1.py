import re
import sys

file = sys.argv[1]
break_at = int(sys.argv[2]) if len(sys.argv) > 2 else -1

counter = 0
regex = re.compile(r'(?P<direction>[LR])(?P<steps>\d+)')
current_position = 50
index = 0

with open(file + '.txt', 'r') as file:
    for line in file:
        match = regex.match(line)
        if match:
            direction = match.group('direction')
            steps = int(match.group('steps'))

            if match.group('direction') == 'L':
                current_position -= steps
            else:
                current_position += steps

            current_position = current_position % 100

            if current_position > 99:
                current_position -= 100
            elif current_position < 0:
                current_position = 100 + current_position

            print(direction, steps, current_position)

            if current_position == 0:
                counter += 1
        index += 1
        if index == break_at:
           break
print(counter)
