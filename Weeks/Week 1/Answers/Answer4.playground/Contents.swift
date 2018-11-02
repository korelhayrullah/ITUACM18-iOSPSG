
func calculateSumDownIteratively(n: Int) -> Int {
  var total = 0
  for num in 1...n {
    total += num
  }
  return total
}

func calculateAllDown(n: Int) -> Int{
  return n * (n + 1) / 2
}

print(calculateSumDownIteratively(n: 3))
print(calculateAllDown(n: 3))

