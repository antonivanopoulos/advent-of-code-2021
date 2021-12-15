import sequtils, tables, algorithm, math

let bracketMap = {
  '}': '{',
  ')': '(',
  ']': '[',
  '>': '<'
}.toTable

let reverseBracketMap = {
  '{': '}',
  '(': ')',
  '[': ']',
  '<': '>'
}.toTable

proc partOne(input: seq[string]): int =
  let scores = {
    '}': 1197,
    ')': 3,
    ']': 57,
    '>': 25137
  }.toTable

  for i, line in input:
    var stack: seq[char]

    for c in line.toSeq:
      if c in toSeq(bracketMap.values): stack.add(c)
      elif bracketMap[c] == stack[^1]: discard stack.pop
      else:
        result += scores[c]
        break

proc partTwo(input: seq[string]): int =
  let points = {
    '}': 3,
    ')': 1,
    ']': 2,
    '>': 4
  }.toTable

  var scores: seq[int]

  for line in input:
    var stack: seq[char]
    var score: int
    var failed: bool

    for c in line.toSeq:
      if c in toSeq(bracketMap.values): stack.add(c)
      elif bracketMap[c] == stack[^1]: discard stack.pop
      else:
        failed = true
        break

    if stack.len > 0 and not failed:
      for i in countdown(stack.high, 0):
        score *= 5
        score += points[reverseBracketMap[stack[i]]]

      scores.add(score)

  return scores.sorted(cmp)[floor(scores.len / 2).int]


let testInput = "./testinput.txt".lines.toSeq

assert partOne(testInput) == 26397
assert partTwo(testInput) == 288957

let input = "./input.txt".lines.toSeq

echo "Part one: ", partOne(input)
echo "Part two: ", partTwo(input)

