import sequtils, strutils

proc mostCommonBit(input: seq[string], idx: int): char =
  var ones = 0
  var zeros = 0
  for line in input:
    if line[idx] == '0':
      zeros += 1
    else:
      ones += 1

  if zeros > ones: return '0'
  elif zeros == ones: return '1'
  else: return '1'

proc leastCommonBit(input: seq[string], idx: int): char =
  let mostCommon = mostCommonBit(input, idx)

  if mostCommon == '0': return '1'
  else: return '0'

proc chooseByFrequency(input: seq[string],
    chooser: proc(input: seq[string], ix: int): char): string =
  var selected = input
  var ix = 0
  while selected.len > 1:
    let commonBit = chooser(selected, ix)
    selected = selected.filterIt(it[ix] == commonBit)
    ix += 1

  selected[0]

proc part1(input: seq[string]): int =
  var gamma, epsilon = ""
  for idx in 0..input[0].high:
    let mostCommon = mostCommonBit(input, idx)
    let leastCommon = leastCommonBit(input, idx)

    gamma.addEscapedChar(mostCommon)
    epsilon.addEscapedChar(leastCommon)

  result = parseBinInt(gamma.join("")) * parseBinInt(epsilon.join(""))

proc part2(input: seq[string]): int =
  let oxygen = chooseByFrequency(input, mostCommonBit)
  let co2 = chooseByFrequency(input, leastCommonBit)

  result = parseBinInt(oxygen.join("")) * parseBinInt(co2.join(""))


let lines = "./input.txt".lines.toSeq

echo "Part 1: ", part1(lines)
echo "Part 2: ", part2(lines)
