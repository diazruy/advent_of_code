import math

class Box:
    def __init__(self, index, x, y, z):
        self.index = index
        self.x = x
        self.y = y
        self.z = z

    def __str__(self):
        return '{:>2}'.format(str(self.index)) + ': ' + '{:>3}, {:>3}, {:>3}'.format(self.x, self.y, self.z)

class Circuit:
    def __init__(self):
        self.boxes = set()

    def add(self, box):
        self.boxes.add(box)

    def size(self):
        return len(self.boxes)

    def contains(self, box):
        return box in self.boxes

    def __str__(self):
        box_indexes = [box.index for box in self.boxes]
        return ', '.join(map(str, sorted(box_indexes)))

class Calculations:
    def __init__(self, file):
        self.file = file
        self.boxes = []
        self.distances = []
        self.circuits = []
        self.read_file()
        self.compute_distances()
        self.compute_circuits()

    def read_file(self):
        with open(self.file + '.txt', 'r') as file:
            for i, line in enumerate(file):
                x, y, z = list(map(int, line.strip().split(',')))
                box = Box(i, x, y, z)
                self.boxes.append(box)

    def distance(self, box_1, box_2):
        return math.sqrt(
            (box_1.x - box_2.x)**2 +
            (box_1.y - box_2.y)**2 +
            (box_1.z - box_2.z)**2)

    def compute_distances(self):
        distances = []
        for i, box_a in enumerate(self.boxes):
            for j, box_b in enumerate(self.boxes):
                if j <= i:
                    continue
                dist = self.distance(box_a, box_b)
                distances.append(dict(a=box_a, b=box_b, distance=dist))
        self.distances = sorted(distances, key=lambda distance: distance['distance'])

    def compute_circuits(self):
        circuits = []
        for distance in self.distances:
            circuit_a = next((circuit for circuit in circuits if circuit.contains(distance['a'])), None)
            circuit_b = next((circuit for circuit in circuits if circuit.contains(distance['b'])), None)

            if not circuit_a and not circuit_b:
                circuit_a = Circuit()
                circuits.append(circuit_a)
            elif circuit_a and circuit_b:
                if circuit_a == circuit_b:
                    continue
                circuit_a.boxes.update(circuit_b.boxes)
                circuits.remove(circuit_b)

            circuit = circuit_a or circuit_b
            circuit.add(distance['a'])
            circuit.add(distance['b'])
            if len(circuit.boxes) == len(self.boxes):
                print(distance['a'].x * distance['b'].x)

        self.circuits = circuits

Calculations('example')
Calculations('input')



