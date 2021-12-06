import sequtils, strutils
import arraymancer

proc parseBoard(input: string): seq[seq[int]] =
  input.split('\n').map(proc(x: string): seq[int] = x.splitWhitespace.map(parseInt))

proc isWinner(mask: Tensor[int]): bool =
  5 == mask.sum(axis = 0).max or
    5 == mask.sum(axis = 1).max

let
  lines = readFile("./input.txt").strip.split("\n\n")
  numbers = lines[0].split(',').map(parseInt)
  boards = lines[1..^1].mapIt(parseBoard(it).toTensor())

var
  masks = boards.mapIt(zeros[int]([5,5]))
  scores: seq[int]
  winners: seq[int]

for number in numbers:
  for i in 0..boards.high:
    masks[i] = (masks[i].astype(bool) or boards[i] ==. number).astype(int)

    if isWinner(masks[i]) and not contains(winners, i):
      let score = sum((1 -. masks[i]) *. boards[i]) * number
      scores.add(score)
      winners.add(i)

echo scores[0]
echo scores[^1]
