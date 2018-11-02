import UIKit

var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

for number in numbers {
  print("Table for \(number)")
  for index in 1...10 {
    print("\(number) x \(index) = \(number * index)")
  }
  print("")
}

func multiplicationTable() {
  for i in 1...9 {
    print("Table for \(i)")
    for j in 1...10 {
      print("\(i) x \(j) = \(i * j)")
    }
    print("")
  }
}

multiplicationTable()
