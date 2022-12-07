ROCK = :rock
PAPER = :paper
SCISSORS = :scissors

CODE_LOSE = 'X'
CODE_DRAW = 'Y'
CODE_WIN = 'Z'

RESULT_POINTS = {
  CODE_LOSE => 0,
  CODE_DRAW => 3,
  CODE_WIN => 6
}

SHAPE_SCORES = {
  ROCK => 1,
  PAPER => 2,
  SCISSORS => 3
}

SHAPE_CODES = {
  'A' => ROCK,
  'B' => PAPER,
  'C' => SCISSORS
}

OFFSETS = {
  CODE_LOSE => -1,
  CODE_DRAW => 0,
  CODE_WIN => 1,
}

SEQUENCE = [ROCK, PAPER, SCISSORS, ROCK, PAPER, SCISSORS]

def shape_for_desired_result(shape_them, result)
  SEQUENCE[SEQUENCE.index(shape_them) + OFFSETS[result]]
end

total_score = 0

File.open('input.txt', 'r') do |file|
  file.each do |line|
    code_them, desired_result = line.split(' ')
    shape_them = SHAPE_CODES[code_them]
    shape_us = shape_for_desired_result(shape_them, desired_result)
    score = RESULT_POINTS[desired_result] + SHAPE_SCORES[shape_us]
    total_score += score
  end
end
puts total_score
