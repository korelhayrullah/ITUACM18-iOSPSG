let numberArray = [1, 2, 33, 100, 435, 1032, 4]

let numberDictionary = [
  0 : "Zero",
  1 : "One",
  2 : "Two",
  3 : "Three",
  4 : "Four",
  5 : "Five",
  6 : "Six",
  7 : "Seven",
  8 : "Eight",
  9 : "Nine"
]


func transformNumbersToWords(_ numberArray: [Int]) -> [String] {
  return numberArray.map { (number) -> String in
    var num = number
    var word = ""
    
    while num != 0 {
      word = numberDictionary[num % 10]! + word
      num /= 10
    }
    
    return word
  }
}


let transformedNumbers = transformNumbersToWords(numberArray)
for index in 0..<numberArray.count {
  print("\(numberArray[index]) = \(transformedNumbers[index])")
}

