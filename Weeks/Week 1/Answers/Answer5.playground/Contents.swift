func calculateSumDownRecursively(n: Int) -> Int {
  if n == 1 {
    return 1
  }
  return n + calculateSumDownRecursively(n: n - 1)
}

print(calculateSumDownRecursively(n: 3))
