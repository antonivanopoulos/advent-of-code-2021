import sequtils, strutils, algorithm

proc countFishies(fishies: seq[int], days: int): int =
  var fishCount: array[9, int]

  for fish in fishies:
    inc fishCount[fish]

  for i in 1..days:
    let producers = fishCount[0]
    fishCount.rotateLeft(1)
    fishCount[6] += producers
    fishCount[8] = producers

  return fishCount.foldl(a + b)

var testFishies = readFile("./testinput.txt").strip.split(',').map(parseInt)

assert countFishies(testFishies, 18) == 26
assert countFishies(testFishies, 80) == 5934
assert countFishies(testFishies, 256) == 26984457539

var fishies = readFile("./input.txt").strip.split(',').map(parseInt)
echo "Part one: ", countFishies(fishies, 80)
echo "Part one: ", countFishies(fishies, 256)

