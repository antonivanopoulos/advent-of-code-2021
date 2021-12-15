import sequtils, strutils
import arraymancer

type OctupusCavern = object
  grid: Tensor[int]
  flashes: int

proc flashAround(cavern: var OctupusCavern, coord: seq[int]) =
  for y in coord[1]-1..coord[1]+1:
    for x in coord[0]-1..coord[0]+1:
      if x >= 0 and x < cavern.grid.shape[0] and y >= 0 and y < cavern.grid.shape[1]:
        cavern.grid[x,y] += 1

proc resolveFlashes(cavern: var OctupusCavern) =
  var flashed = zeros[int](cavern.grid.shape).astype(bool)
  var flashing = (cavern.grid >. 9)

  while flashing.astype(int).sum > 0:
    for coord, flash in flashing:
      if flash:
        cavern.flashAround(coord)

    flashed = flashed or flashing
    flashing = (cavern.grid >. 9) and not flashed

  cavern.flashes += flashed.astype(int).sum
  cavern.grid *.= (1 -. flashed.astype(int))

proc step(cavern: var OctupusCavern) =
  cavern.grid +.= 1
  cavern.resolveFlashes()

proc partOne(input: seq[seq[int]], days: int): int =
  var cavern = OctupusCavern(grid: input.toTensor, flashes: 0)

  for i in 1..days:
    cavern.step()

  return cavern.flashes

proc partTwo(input: seq[seq[int]]): int =
  var cavern = OctupusCavern(grid: input.toTensor, flashes: 0)

  while true:
    inc result
    cavern.step()

    if cavern.grid.allIt(it == 0):
      break

let testInput = "./testinput.txt".lines.toSeq.mapIt(it.toSeq.mapIt(parseInt($it)))

assert partOne(testInput, 10) == 204
assert partOne(testInput, 100) == 1656
assert partTwo(testInput) == 195

let input = "./input.txt".lines.toSeq.mapIt(it.toSeq.mapIt(parseInt($it)))

echo "Part one: ", partOne(input, 100)
echo "Part two: ", partTwo(input)
