import UIKit
// Week 2 (01/11/18)
// Swift Fundamentals (enumerations, structs, classes, inheritance, extensions, protocols, generics)
// Lecture notes

// EXTENSIONS

// You can extend an existing class or struct using the "extension" keyword
// and add the properties or methods as you wish

// Example
extension Double {
  var intValue: Int {
    return Int(self)
  }
  var floatValue: Float {
    return Float(self)
  }
}
// Usage:
let integer = 5
let double = 3.14
// you cannot sum two different types
let sum = integer + double.intValue
print("The sum is \(sum)")


// ENUMERATIONS
// You can declare an enumeration with the "enum" keyword
// With enumerations you can define groups and work with them in a safer way

// Example
enum Operation {
  case addition
  case subtraction
  case division
  case multiplication
  case exponential

  var stringSign: String {
    switch self {
    case .addition:
      return "+"
    case .subtraction:
      return "-"
    case .division:
      return "/"
    case .multiplication:
      return "*"
    case .exponential:
      return "^"
    }
  }
}
// We have defined an operations enumeration having arithmetic operations
// also if we want to get the sign of the arithmetic operation the calculated property
// stringSign will return us the corresponding sign
// We will use that enum later


// STRUCTS
// We define a struct with the "struct" keyword.
// Example
struct CalculatorMemory {
  let number1: Double
  let number2: Double
  let opeartion: Operation
  let result: Double
}
// Now we have defined a struct named CalculatorMemory which we will use it later on creating
// a calculator which this struct will be responsible of holding a record of the previous
// calculations made


// PROTOCOLS
// We define a protocol with the "protocol" keyword. Protocols helps us to set blueprints
// of methods and properties that can be adpoted by enumerations, structs, classes. Protocols
// cannot have a body. They help us to set the requirements for the adopting class, struct or
// enumereation

// Example
protocol CalculatorDelegate: class {
  func calculatorDidCalculateValue(_ calculator: Calculator, calculatedValue: Double)
  func calculatorDidGetError(_ calculator: Calculator, error: String)
}
// This protocol will be used later on as our blueprint methods for getting the result and
// error of our calculator


// CLASSES
// We define a class with the "class" keyword. Classes are like structs, but have a wider
// range of operation. Keep in mind that classes are reference types and structs value types.

// Example
class Calculator {
  // MARK: -Properties
  
  // a private variable for storing the result
  private var result: Double
  
  // a memory, an array of the type CalculatorMemory we defined earlier
  // for storing the previous calculations
  private var memory: [CalculatorMemory]
  
  // a delegate to our protocol. If set it will make use of its blueprint methods
  // it is defined as a weak reference in order to avoid strong reference cycles
  // preventing memory leaks.
  // Read more here: https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
  weak var delegate: CalculatorDelegate?
  
  // MARK: -Methods
  init() {
    // initialize properties
    // at the very beginning the result is 0 and the memory doesn't contain
    // any previous calculations so initialize the array as an empty array
    self.result = 0
    self.memory = []
  }
  
  // a method to get the previous calculations
  func getHistory() -> [CalculatorMemory] {
    return memory
  }
  
  // a method to get the last calculation
  func getPreviousCalculation() -> CalculatorMemory? {
    return memory.last
  }
  
  // a method showing the previous calculations if any exist
  func showHistory() {
    print("\nHISTORY\n")
    guard memory.count != 0 else {
      print("No history yet!")
      return
    }
    
    for history in memory {
      print("\(history.number1) \(history.opeartion.stringSign) \(history.number2) = \(history.result)")
    }
  }
  
  // a method showing the last calculation if any exist
  func showLastCalculation() {
    print("\nLast Calculation\n")
    guard let last = memory.last else {
      print("No history yet!")
      return
    }
    print("\(last.number1) \(last.opeartion.stringSign) \(last.number2) = \(last.result)")
  }
  
  // a method to perform the calculation
  // this method is the main method of this class since this class's job is to calculate :D
  
  // it takes two numbers of type Double to calculate according to the operation
  // note that the operation is the enumeration we defined earlier consisting of
  // arithmetic operations
  func calculate(operation: Operation, number1: Double, number2: Double) {
    // there is a switch case to distinguish the operation
    // e.x. if the operation is addition it will add the given two numbers and
    // set it to the result variable of this class
    switch operation {
    case .addition:
      result = number1 + number2
    case .subtraction:
      result = number1 - number2
    case .multiplication:
      result = number1 * number2
    case .division:
      if number2 == 0 {
        // here we know that division by 0 is a mathematical error
        // so with the use of the delegate we return it as a Division by zero error
        // note that the delegate is an optional it will work only if the
        // delegate is set
        guard let delegate = delegate else { return }
        delegate.calculatorDidGetError(self, error: "Division by zero")
      } else {
        // if no errors occur it will do the division as expected
        result = number1 / number2
      }
    case .exponential:
      // the pow method raises number2 over number1
      // e.x number1 = 2, number2 = 4 it is 2^4
      // P.S. We could have improved this operation. Maybe you can make it better :D
      result = pow(number1, number2)
    }
    
    
    // after the calculation we initialize our previously defined struct with the numbers, opeation and result to store it in our calculator's memory.
    let history = CalculatorMemory(number1: number1,
                                   number2: number2,
                                   opeartion: operation,
                                   result: result)
    
    // appending the last calculation to our array which represents our memory
    memory.append(history)
    
    // if the delegate is set then show the result of the calculator, the delegate must be set
    // in order to retrieve the result
    // P.S. This method could just return its result, but to show use protocols and delegates
    // we used that way
    guard let delegate = delegate else { return }
    delegate.calculatorDidCalculateValue(self, calculatedValue: result)
  }
  
  // a method to clear the calculations' memory
  func clearHistory() {
    memory = []
  }
}

// The new class Casio which is a widely known bran for calculator inherits the Calculator
// class we just implemented
class Casio: Calculator {}

// we extend the Casio class by conforiming it to our prtocol and utilizing the blueprint
// methods we defined
extension Casio: CalculatorDelegate {
  func calculatorDidGetError(_ calculator: Calculator, error: String) {
    print("Error: \(error)")
  }
  
  func calculatorDidCalculateValue(_ calculator: Calculator, calculatedValue: Double) {
    print("Result \(calculatedValue)")
  }
}

// now it is time to use our calculator
// initializing Casio
let casio = Casio()
// setting the delegate to itself
casio.delegate = casio

// testing our methods
casio.showLastCalculation()
casio.calculate(operation: .addition, number1: 2, number2: 3)
casio.calculate(operation: .exponential, number1: 2, number2: 3)
casio.calculate(operation: .subtraction, number1: 2, number2: 3)


casio.showHistory()
casio.showLastCalculation()

casio.clearHistory()

casio.showHistory()


// GENERICS
// Generics helps us to reuse our code for any type. It helps us to write readable,
// reusable and flexible codes.

// As an example consider a swap function that swaps the given values

// Example
var a = 5
var b = 4
print(" Before swapping a is \(a) and b is \(b)")

let temp = a
a = b
b = temp

print("After swapping a is \(a) and b is \(b)")

// we can write a function to achieve swapping
// inout here takes their reference and swaps their values
// the parameters aren't copied, their real values are passed
// and can be modified
func swap(n1: inout Int, n2: inout Int) {
  let temp = n1
  n1 = n2
  n2 = temp
}

swap(&a, &b)
print("After swapping again a is \(a) and b is \(b)")

// wouldn't it be nice to have a generic swap function that can swap any given values?
// We need generics to achive that, if that was not possible we had to write a swap function
// for every type

// We define a generic function by giving a placholder in between "<>" right after the
// name of the function and use the placeholder as the type for our values
// So, swift can infer from the given type. Note that, you cannot give an Int for n1 and Double
// for n2. Whatever T is the others must also be of type T.
func swap<T>(n1: inout T, n2: inout T) {
  let temp = n1
  n1 = n2
  n2 = temp
}

// now we can swap any two values regardless its type

var doubleVal1 = 5.2
var doubleVal2 = 1.2

print(" Before swapping a is \(doubleVal1) and b is \(doubleVal2)")
swap(&doubleVal1, &doubleVal2)
print(" After swapping a is \(doubleVal1) and b is \(doubleVal2)")
// you can try other types


// MORE EXAMPLES

// Defining a protocol for a stack data structure
// a stack is a common used data structure in computer science
// and it should have properties like count, isEmpty and container.
// So, we make sure that classes or structs conforming to that protocol
// will have those properties
// A struct is a data structure that puts the given value on top and if requested
// it returns us the last put value. LIFO (Last in first out). Stack :D

protocol StackProtocol {
  // Protocols cannot be of generic type. In order to achieve generic type
  // methods or properties associatedtype and a placholder must be used
  // After conforming to that protocol the compiler will infer the type
  associatedtype T
  var count: Int { get }
  var isEmpty: Bool { get }
  var container: [T] { get }
}


// defining a generic class as the function and using T for the types in our class
class Stack<T>: StackProtocol {
  internal var container: [T]
  
  var count: Int {
    return container.count
  }
  
  var isEmpty: Bool {
    return container.count == 0
  }
  
  init() {
    container = []
  }
  
  func push(item: T) {
    container.append(item)
  }
  
  func pop() -> T? {
    return container.popLast()
  }
  
  func getItems() -> [T] {
    return container
  }
  
  func showItems() {
    for item in container {
      print(item, separator: " ")
    }
    print("")
  }
}

let myStack = Stack<Int>()
myStack.push(item: 1)
myStack.push(item: 2)
myStack.push(item: 3)

myStack.showItems()
print(myStack.pop() ?? "Stack is empty!")
myStack.showItems()



// INHERITANCE
class Shape {
  public var area: Double {
    return 0
  }
}

class Rectangle: Shape {
  private var length: Double
  private var height: Double
  
  override var area: Double {
    return length * height
  }
  
  init(length: Double, height: Double) {
    self.length = length
    self.height = height
  }
}

class Square: Shape {
  private var sideLength: Double
  
  override var area: Double {
    return sideLength * sideLength
  }
  
  init(sideLength: Double) {
    self.sideLength = sideLength
  }
}

class Circle: Shape {
  private var radius: Double
  
  override var area: Double {
    return Double.pi * radius * radius
  }
  
  init(radius: Double) {
    self.radius = radius
  }
}


let circle = Circle(radius: 5)
print(circle.area)

let square = Square(sideLength: 5)
print(square.area)

let rectangle = Rectangle(length: 5, height: 2)
print(rectangle.area)



