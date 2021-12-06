import sequtils, strscans, math
import arraymancer

proc drawVent(grid: var Tensor[int], x1, y1, x2, y2: int) =
  let
    x_step = sgn(x2 - x1)
    y_step = sgn(y2 - y1)

  var
    x = x1
    y = y1

  while x != x2 or y != y2:
    grid[y,x] += 1
    x += x_step
    y += y_step
  grid[y2,x2] += 1

proc part1(lines: seq[string]): int =
  var grid = zeros[int]([1000,1000])
  for line in lines:
    let (success, x1, y1, x2, y2) = line.scanTuple("$i,$i -> $i,$i")

    if success and (x1 == x2 or y1 == y2):
      drawVent(grid, x1, y1, x2, y2)

  return (grid >. 1).astype(int).sum

proc part2(lines: seq[string]): int =
  var grid = zeros[int]([1000,1000])
  for line in lines:
    let (success, x1, y1, x2, y2) = line.scanTuple("$i,$i -> $i,$i")

    if success:
      drawVent(grid, x1, y1, x2, y2)

  return (grid >. 1).astype(int).sum

let lines = "./input.txt".lines.toSeq

echo "Part 1: ", part1(lines)
echo "Part 2: ", part2(lines)

