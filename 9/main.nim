import sequtils, strutils, algorithm

type point = tuple[x,y: int]

proc detectLowPoint(input: seq[seq[int]], x, y: int): bool =
  var up, down, left, right = false

  if y == 0: up = true else: up = input[y][x] < input[y-1][x]
  if y == input.high: down = true else: down = input[y][x] < input[y+1][x]
  if x == 0: left = true else: left = input[y][x] < input[y][x-1]
  if x == input[0].high: right = true else: right = input[y][x] < input[y][x+1]

  return up and down and left and right

proc measureBasin(input: seq[seq[int]], x, y: int): seq[point] =
  result.add((x,y))

  if y > 0 and input[y-1][x] > input[y][x] and input[y-1][x] != 9: result = concat(result, measureBasin(input, x, y-1))
  if y < input.high and input[y+1][x] > input[y][x] and input[y+1][x] != 9: result = concat(result, measureBasin(input, x, y+1))
  if x > 0 and input[y][x-1] > input[y][x] and input[y][x-1] != 9: result = concat(result, measureBasin(input, x-1, y))
  if x < input[0].high and input[y][x+1] > input[y][x] and input[y][x+1] != 9: result = concat(result, measureBasin(input, x+1, y))

  return result

proc partOne(input: seq[seq[int]]): int =
  var lows: seq[int]

  for i in 0..input.high:
    for j in 0..input[0].high:
      if detectLowPoint(input, j, i):
        lows.add(input[i][j])

  return lows.mapIt(it + 1).foldl(a + b)

proc partTwo(input: seq[seq[int]]): int =
  var basins: seq[seq[point]]

  for i in 0..input.high:
    for j in 0..input[0].high:
      if detectLowPoint(input, j, i):
        basins.add(measureBasin(input, j, i))

  return basins.mapIt(it.deduplicate.len).sorted(cmp)[^3..^1].foldl(a * b)


let testInput = "./testinput.txt".lines.toSeq.mapIt(it.toSeq.mapIt(parseInt($it)))

assert partOne(testInput) == 15
assert partTwo(testInput) == 1134

let input = "./input.txt".lines.toSeq.mapIt(it.toSeq.mapIt(parseInt($it)))

echo "Part one: ", partOne(input)
echo "Part two: ", partTwo(input)
