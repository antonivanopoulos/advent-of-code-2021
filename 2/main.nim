import sequtils, strscans

let commands = "./input.txt".lines.toSeq

var x,y,aim = 0
for command in commands:
  let (success, direction, X) = command.scanTuple("$+ $i", string, int)

  if success:
    case direction:
    of "forward":
      x += X
      y += aim * X
    of "down":
      aim += X
    of "up":
      aim -= X

echo "Part 1: ", x*aim
echo "Part 2: ", x*y
