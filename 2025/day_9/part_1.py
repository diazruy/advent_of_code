class Tile:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return str(self.x) + ',' + str(self.y)

class Calculations:
    def __init__(self, file):
        self.file = file
        self.tiles = []
        self.read_file()

    def read_file(self):
        with open(self.file + '.txt', 'r') as file:
            for line in file:
                x, y = list(map(int, line.strip().split(',')))
                self.tiles.append(Tile(x, y))

    def max_area(self):
        max_area = 0
        for i, tile_a in enumerate(self.tiles):
            for j, tile_b in enumerate(self.tiles):
                if j <= i:
                    continue
                area = self.area(tile_a, tile_b)
                if area > max_area:
                    max_area = area
        return max_area

    def area(self, a, b):
        return (abs(a.x - b.x) + 1) * (abs(a.y - b.y) + 1)

print(Calculations('example').max_area())
print(Calculations('input').max_area())
