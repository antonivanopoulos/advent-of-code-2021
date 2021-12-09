import sequtils, strutils
import arraymancer

proc calculateFuel(crabs: Tensor[int], costCalculator: proc(x: int): int): int64 =
  var lowest = 1_000_000_000_000

  for n in crabs.min..crabs.max:
    let d = (crabs -. n).abs
    lowest = min(lowest, d.map(costCalculator).sum)

  return lowest

proc partOne(crabs: Tensor[int]): int64 =
  calculateFuel(crabs, proc(x: int): int = x)

proc partTwo(crabs: Tensor[int]): int64 =
  let calculator = proc(x: int): int =
    int(x * (x + 1) / 2)
  calculateFuel(crabs, calculator)

var testCrabs = readFile("./testinput.txt").strip.split(',').map(parseInt).toTensor()

assert partOne(testCrabs) == 37
assert partTwo(testCrabs) == 168

var crabs = readFile("./input.txt").strip.split(',').map(parseInt).toTensor()

echo "Part one: ", partOne(crabs)
echo "Part two: ", partTwo(crabs)
