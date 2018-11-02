import UIKit

var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var numbersIndex = 0

while numbersIndex != 10 {
  var counter = 1
  print("Table for \(numbers[numbersIndex])")
  while counter != 11 {
    print("\(numbers[numbersIndex]) x \(counter) = \(numbers[numbersIndex] * counter)")
    counter += 1
  }
  numbersIndex += 1
  print("")
}


func multiplicationTable() {
  var i = 0
  while i <= 9 {
    print("Table for \(i)")
    var counter = 1
    while counter <= 10 {
      print("\(i) x \(counter) = \(i * counter)")
      counter += 1
    }
    i += 1
    print("")
  }
}

multiplicationTable()
