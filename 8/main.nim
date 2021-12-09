import sequtils, strutils, sets, algorithm

type Input = tuple[displays: seq[string], output: seq[string]]

proc parseInput(input: string): Input =
  let s = input.split(" | ")
  let (displays, output) = (s[0], s[1])

  return (displays.split.mapIt(it.sorted(cmp).join), output.split.mapIt($it.sorted(cmp).join))

proc partOne(input: seq[Input]): int =
  for line in input:
    result += line.output.filterIt([2,3,4,7].contains(len(it))).len

proc partTwo(input: seq[Input]): int =
  for line in input:
    var digits: array[10, string]

    digits[1] = line.displays.filterIt(it.len == 2)[0]
    digits[4] = line.displays.filterIt(it.len == 4)[0]
    digits[7] = line.displays.filterIt(it.len == 3)[0]
    digits[8] = line.displays.filterIt(it.len == 7)[0]
    digits[3] = line.displays.filterIt(it.len == 5).filterIt(len(it.toHashSet * digits[1].toHashSet) == 2)[0]
    digits[2] = line.displays.filterIt(it.len == 5).filterIt(len(it.toHashSet * digits[4].toHashSet) == 2)[0]
    digits[5] = line.displays.filterIt(it.len == 5).filterIt(not digits.contains(it))[0]
    digits[6] = line.displays.filterIt(it.len == 6).filterIt(len(it.toHashSet * digits[1].toHashSet) == 1)[0]
    digits[0] = line.displays.filterIt(it.len == 6).filterIt(len(it.toHashSet * digits[5].toHashSet) == 4)[0]
    digits[9] = line.displays.filterIt(it.len == 6).filterIt(not digits.contains(it))[0]

    result += line.output.mapIt(digits.find(it)).join.parseInt

let testInput = "./testinput.txt".lines.toSeq.map(parseInput)

assert partOne(testInput) == 26
assert partTwo(testInput) == 61229

let input = "./input.txt".lines.toSeq.map(parseInput)

echo "Part one: ", partOne(input)
echo "Part two: ", partTwo(input)
