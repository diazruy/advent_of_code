WIN = 6
DRAW = 3
LOSE = 0

ROCK = :rock
PAPER = :paper
SCISSORS = :scissors

SCORES_SHAPES = {
  ROCK => 1,
  PAPER => 2,
  SCISSORS => 3
}

def shape(value)
  case value
  when 'A', 'X' then :rock
  when 'B', 'Y' then :paper
  when 'C', 'Z' then :scissors
  end
end

def score_result(them, us)
  return DRAW if them == us

  case them
  when ROCK
    us == PAPER ? WIN : LOSE
  when PAPER
    us == SCISSORS ? WIN : LOSE
  when SCISSORS
    us == ROCK ? WIN : LOSE
  end
end

total_score = 0

File.open('input.txt', 'r') do |file|
  file.each do |line|
    them, us = line.split(' ').map { |value| shape(value) }
    total_score += score_result(them, us) + SCORES_SHAPES[us]
  end
end
puts total_score
