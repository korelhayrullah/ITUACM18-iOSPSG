import Foundation

extension Array where Element: Comparable {
  func bubbleSort(order: SortOrder) -> [Element] {
    var array = self
    for i in 0..<array.count - 1 {
      for j in 0..<(array.count - i - 1) {
        if order == .descending {
          if array[j] < array[j + 1] {
            array.swapAt(j, j + 1)
          }
        } else {
          if array[j] > array[j + 1] {
            array.swapAt(j, j + 1)
          }
        }
      }
    }
    return array
  }
}

enum SortOrder {
  case ascending
  case descending
}

var array: [Int] = []
for _ in 0..<100 {
  array.append(Int.random(in: 0..<100))
}

print("")
print(array)
print("Sorted:")
print(array.bubbleSort(order: .ascending))


var array2: [Double] = []
for _ in 0..<100 {
  array2.append(Double.random(in: 0..<100))
}

print("")
print(array2)
print("Sorted:")
print(array2.bubbleSort(order: .descending))
