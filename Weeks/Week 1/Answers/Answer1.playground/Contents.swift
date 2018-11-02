var numberArray: [Int] = []

for _ in 0...50 {
  numberArray.append(Int.random(in: 0...100))
}

func findMaxMin(of numberArray: [Int]) -> (max: Int, min: Int) {
  var min = Int.max
  var max = Int.min
  for number in numberArray {
    if number > max {
      max = number
    }
    if number < min {
      min = number
    }
  }
  return (max, min)
}


let maxMin = findMaxMin(of: numberArray)
print("The maximum is \(maxMin.max) and the minimum is \(maxMin.min)")


