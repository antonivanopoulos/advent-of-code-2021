import sequtils, strutils

let depths = "./input.txt".lines.toSeq.map(parseInt)

proc countIncreases(depths: seq[int], window: int): int =
  for i in window..depths.high:
    if depths[i] > depths[i-window]:
      inc result

echo "Part 1: ", countIncreases(depths, 1)
echo "Part 2: ", countIncreases(depths, 3)
