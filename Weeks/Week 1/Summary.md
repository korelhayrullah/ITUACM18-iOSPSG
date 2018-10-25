# Week 1 -  Summary

### Comments

```swift
// this is a line comment

/*
multiline comment
multiline comment
multiline comment
*/

// comments can be nested

/*
A multiline comment
	/* 
	A nested multiline comment
	*/
*/
```



### Constants and variables

```swift
// we can declare a constant with the let keyword
// we can not change its value after decleration
// so a initial value must be provided since they\
// can't be changed afterwards
let constantVariable = 5

// we can declare a variable with the var keyword
// on contrary to constant variables can be changed any time in runtime
var variable = 4
// then at some point change it to 10
variable = 10 // it is ok

// but
constantVariable = 6 // will give a runtime error

// declaring an integer variable
var integerVar = 5

// declaring a double variable
// there are two floating point types float and double
// Swfit automatically infers the type to double
// in a 64-bit system double is a 64-bit and float is a 32-bit variable
// in order to declare a float, the keyword Float must be explicitly provided
var doubleVar = 3.1415

// declaring a float variable
var floatVar: Float = 3.14

// the maximum positive and negative value that float can hold is 10000000.0. If set to the value 10000000.01 then it will overflow, in such cases we need a more bigger type to hold our number which is Double type. Swift programming language handles that for us by implicitly referring its type to Double when a floating point number is given in order to prevent such cases. 
// Tip: If you 100% sure that the number won't overflow, you can explicitly use Float type for better memory optimization.


// declaring a string variable
var stringVar = "This is a string"
// note that strings are put arount ""

// Note that after declaring a variable, it is type is inferred from what is given to it. So, you can change it in runtime, however, you cannot change its type anymore.

stringVar = 5 // will cause a runtime error
```



### Type annotations

```swift
// type annotations are for being clear about the type of a constant or variable
// If we provide its type, then it is called explicitly declared variable

// examples

// A float variable
var floatVar: Float = 3.1415
// A string variable
var stringVar: String = "Hello, World!"
// An integer variable
var integerVar: Int = 5
// A double variable
var doubleVar: Double = 3.1415
// A character variable
var characterVar: Character = "A"
```



### Naming constants and variables

```swift
// you can name a constant or a variable as you wish
// it supports unicode characters

// from the documentation
// let π = 3.14159
// let 你好 = "你好世界"
// let 🐶🐮 = "dogcow"

// some rules
// 1 variables and constants cannot containt whitespace characters
// 2 cannot start with a number, but can included afterwards
// 3 two variables with the same name cannot be declared
```



### Printing constants and variables

```swift
// you can print anyting using the built in function print()
var number = 15
print(number)

// you can also directly print a string, integer, double, float...
print(4)
print(3.14)
print("Hello, World!")

// you can also print a string with variables included
let age: Int = 18
print("My name is Alex and I am \(age) years old.")

// -> \() <- this is called string interpolation. It puts the variable in and casts it as a string
```



### Semicolons

```swift
// Many programming languages makes you put a semicolon (;) at end of each line. In Swift, they are optional. Whether you put or not, nothing will change. However, if you want to put more than one operation in one line you have to put a semicolon to seperate it for the compiler.

let name = "Korel";
print(name)
// prints Korel

let surname = "Chairoula"; let age = 23; print("My name is \(name) \(surname) and I am \(age) years old.");
// prints My name is Korel Chairoula and I am 23 years old.
```



### Booleans

```swift
// boolean is a logical type that can only contain two options: true or false

var booleanVarTrue = true
var booleanVarFalse = false

// Explicitly declared boolean
var explicitlyDeclaredBoolean: Bool = false

// unlike other languages you cannot use an integer value of 0 to be false and any other than 0 as true. It will report an error during compilation.
```



### Tuples

```swift
// tuples group multiple values in one single variable or constant
// the types can be different

let tuple = ("Korel", "Chairoula", 23)
print(tuple)
// prints "Korel", "Chairoula", 23)

// explicitly declared tuple
let tupleExplicit: (String, String, Int) = tuple
print(tupleExplicit)
// prints "Korel", "Chairoula", 23)

// tuple's value can be accessed by numbers according to their order
print(tupleExplicit.1)
// prints Chairoula

// Note that counting in many programming langugages start from 0 :)

// you can also provide arguments to tuples instead of retrieving the values in a tuple with numbers

let tupleWithArguments: (name: String, surname: String, age: Int) = tuple
print(tupleWithArguments.name)
// prints Korel
```



### Optionals

```swift
// optional values are used in situtations where its value may be absent
// an optional value indicates that either there is a value or there isn't a value at all
// you can declare an optinal value by putting a question mark (?) at the end of the type declaration

var optinalValue: Int? = 5

// the line above means that there can be a value of type Int or not a value at all which is nil. Nil means nothing, is a valueless type

// if you want to use an optional value you may want it to unwrap which can be done by putting an exclamation mark (!) at the end of the variable

print(optionalValue!)
// prints 5

// if printed without unwrapping
print(optionalValue)
// prints (Optional(5))

// Note that in cases where the value of an optional is absent force unwrapping it wihtout any checking will cause a runtime error

var optionalValue2: Double? = nil
print(optionalValue2!) // this is called force unwrapping
// runtime error

// to be more safe unwrapping optinals there are some ways to achieve this safety

// if statements and force unwrapping
if optionalValue != nil {
    print(optionalValue!)
} else {
    print("optionalValue is nil")
}

// optional binding
if let unwrappedOptionalValue = optionalValue {
    print(unwrappedOptionalValue)
} else {
    print("optionalValue is nil")
}
```

See more ways [here](https://github.com/bundlenews/internship-daily-questions/blob/master/answers/answer1.md).

### Basic operators

There are 3 types of operators: unary, binary and ternary.

###### Unary operators (!, +, -)

```swift
// not operator (!)
// it reverses the logic (true to false, false to true)
var boolVal = false
print(boolVal)
// prints false
boolVal = !boolVal
print(boolVal)
// prints true

// plus and minus operators (+, -)
// it basically multiplies the value with the opeartor
var integer = 5
print(-integer)
// prints -5
print(+integer)
// prints 5 
```

###### Binary operators (=, +, -, *, /, %, ==, !=, <, > , <=, >=)

```swift
// assignment operator (=)
var value1 = 5
var value2 = value1
// value2 equals value1 which is 5
// it set the value from right to left

// arihtmetic operators (+, -, *, /, %)
let value3 = 6
let value4 = 3
var result = 0
// plus operator (+)
result = value3 + value4
print(result)
// prints 9

// you can also add two string together
var string1 = "Hello, "
var string2 = "class."
print(string1 + string2)
// prints Hello, class.

// minus operator (-)
result = value3 - value4
print(result)
// prints 3

// multiply operator (*)
result = value3 * value4
print(result)
// prints 18

// division operator (/)
result = value3 / value4
print(result)
// prints 2

// remainder operator (%)
result = value3 % value4
print(result)
// prints 0

// Note: If you want to do an arithmetic operation including itself there is a shorthand syntax for it

// example in addition
var counter = 0
// long version to increment counter by one
counter = counter + 1
// short version to increment counter by one
counter += 1
// both do the same operation, just a shorter syntax
// -=, *=, /= can be performed as shown above


// comparison operators (==, !=, >, <, >=, <=)
// equal to operator (==)
if 5 == 5 {
    print("5 is equal to 5")
} else {
    print("5 is not equal to 5")
}
// prints 5 is equal to 5

// not equal operator (!=)
if 5 != 6 {
    print("5 is not equal to 6")
} else {
    print("5 is equal to 6")
}
// prints 5 is not equal to 6

// greater (>), less (<), greater than or equal to (>=), less than or equal to (<=) operators

var dailyExpense = 50

if dailyExpense <= 10 {
  print("Not bad")
} else if dailyExpense <= 30 {
  print("You saved the day")
} else if dailyExpense <= 50 {
  print("You are rich for a student.")
} else if dailyExpense <= 100 {
  print("You are rich.")
} else {
  print("OMG you are super rich.")
}
// prints You are rich for a student.

// in this example "<=" operator is been used, but all the other operators are the same
```

###### Ternary opearator

Besides binary and unary oparators, there is one single operator which is the ternary operator **question ? answer1: answer2**. It basically evaluates the question, if the question is true the first value after the question mark is taken otherwise the second value after the question mark is taken

```swift
let totalGrade = 50
let gradeToPassLecture = 40

let pass = totalGrade >= gradeToPassLecture ? true : false

if pass {
  print("You have passed the lecture.")
} else {
  print("Come back next year :/")
}
```



### Collection Types

There are primary 3 collection types which are arrays, dictionaries and sets.

###### Arrays

Arrays store the same type of values in an ordered list.

```swift
// shorthand syntax for array decleration
var intArray = [Int]()

// the long way
var doubleArray = Array<Double>()

// also when the type is explicitly given then
var stringArray: [String] = []

// arrays can also have initial values set
var arrayWithSomeInts = [1, 2, 3, 4]
// var arrayWithSomeInts: [Int] = [1, 2, 3, 4]
// both of the array above are the same. Swift can infer its type when initial value(s) are given, so in that case the type [Int] is automatically referred by Swift

// you can access an array's value by using the subscripting operator (note that indexing starts from 0)
print(arrayWithSomeInts[0])
// prints 1

// IMPORTANT: If you want to access to an index that exceeds the array's size you will get a runtime error 

// to get the total elements of the array use the count property
print(arrayWithSomeInts.count)
// prints 4

// to append a value to the array the append(_:) method is used
arrayWithSomeInts.append(5)
// the array now is [1, 2, 3, 4, 5]

// to remove a value the remove(at:) method is used which removes the value at given index
arrayWithSomeInts.remove(at: 3)
// removes 4 from the array
// the array now is [1, 2, 3, 5]

// to insert a value to a specific location insert(_:at:) method is used where _: is the value and at: is the index to be put
arrayWithSomeInts.insert(4, at: 3)
// the array now is [1, 2, 3, 4, 5]
```

######  Sets

Unlike arrays sets are unordered lists which can contain a value only once.

```swift
// set declerations 
var set = Set<Int>()
var set2: Set<Int> = []
// unfortunately, there is not a shorthand syntax for sets decleration

// to insert a value to the set use the insert(newMember:) method
set.insert(1)
set.insert(2)
set.insert(3)
set.insert(4)
// the set now contains 1, 2, 3, 4 and note that they are not ordered like in arrays

// to get the total elements of the set use the count property

print(set.count)
// prints 4

// to remove a value to the set use the remove(member:) method
set.remove(2)
// removes 2 from the set\

// sets can contain a value once
set.insert(10)
// insert the value 10
// set contains 1, 3, 4, 10
set.insert(10)
// insert the value 10 again
// set contains 1, 3, 4, 10. Nothing changed.
```

###### Dictionaries

```swift
// shorthand syntax for dictionary decleration
var dictionary = [Int : String]()

// the long way
var dictionary1 = Dictionary<Int, String>()

// also when the type is explicitly given then
var strindictionary2: [Int: String] = [:]
// important here: don't forget the : in [:] as in the lecture I did :/

// adding a value to the dictionary
dictionary[0] = "Zero"
dictionary[1] = "One"
dictionary[2] = "Twoo"

print(dictionary)
//prints [2: "Twoo", 0: "Zero", 1: "One"]

// remove a value from dictionary
dictionary[0] = nil
dictionary.removeValue(forKey: 0) // does the same
// check the return value of method

print(dictionary)
// prints [2: "Twoo", 1: "One"]

// update a value from dictionary
dictionary[2] = "Two"
dictionary.updateValue("Two", forKey: 2) // does the same
// check the return value of method

print(dictionary)
// prints [2: "Two", 1: "One"]

// get a value from dictionary
// note that when getting a value the value is returned as optional
// the value for that key may be there or not
// use safe unwrapping methods here, but since I know there is a value for the key 1
// I will force unwrap it

print(dictionary[1]!)
// prints One

// the property keys returns all the keys for that dictionary
print(dictionary.keys)
// prints [2, 1]

// the property values returns all the values for that dictionary
print(dictionary.values)
// prints ["Two", "One"]

// the property count returns the total key value paris in that dictionary
print(dictionary.count)
// prints 2

```



### Control Flow

###### If statement

```swift
var dailyExpense = 50

if dailyExpense <= 10 {
  print("Not bad")
} else if dailyExpense <= 30 {
  print("You saved the day")
} else if dailyExpense <= 50 {
  print("You are rich for a student.")
} else if dailyExpense <= 100 {
  print("You are rich.")
} else {
  print("OMG you are super rich.")
}
// prints You are rich for a student.
```

###### Switch statement

```swift
let letterGrade = "CC"

switch letterGrade {
case "AA":
  print("Passed lecture with a score of 4.0")
case "BA":
  print("Passed lecture with a score of 3.5")
case "BB":
  print("Passed lecture with a score of 3.0")
case "CB":
  print("Passed lecture with a score of 2.5")
case "CC":
  print("Passed lecture with a score of 2.0")
case "DC":
  print("Passed lecture with a score of 1.5")
case "DD":
  print("Passed lecture with a score of 1.0")
case "FF":
  print("Failed")
default:
  print("Cannot enter final. Failed.")
}
// prints Passed lecture with a score of 2.0

// In switch statements whenever the suitable case is met it immediately breaks out the switch statement. In C++ you have to put a break right before the case's last line to prevent entering the next cases. In Swift, it is optional, it automatically breaks out as soon as the case's lines are executed. If you want to continue, you have to write the keyword "fallthrough". See the documentation for more detail.
```

###### For-In loops

```swift
var array = [1, 2, 3, 4, 5]

for value in array {
    print(value)
}
// prints
// 1
// 2
// 3
// 4
// 5
```

###### While Loops

While loops continue until a certain condition is met.

```swift
var counter = 0
while counter < 5 {
    counter = counter + 1
    print(counter)
}
// prints
// 1
// 2
// 3
// 4
// 5

// Note that if give true to a while loop, it will run forever which is called infinite loop
while true {
    // runs forever
}
// TIP: If you write a loop and it runs forever, probably it is an unexpected behavior and your condition logic is probably wrong if not explicitly said
```

###### Repat-While

Repeat-while is like while loops, but whether the condition is true or not, it will enter once to the repeat scope and run the lines that are set in. 

```swift
repeat {
  print("At least once")
} while false
// prints At least once
```



### Functions

```swift
// functions are code pieces that can be used over and over. The basic operation is that they take an input and return an output.

// functions in Swift are declared with the func keyword following the name of the function, arguments and return value if needed.

// a function without an argument and return value
func sayHello() {
    print("Hello, World!")
}

sayHello()
// prints Hello, World!

// a function without a return value
func welcome(name: String) {
  print("Hello \(name)!")
}

welcome(name: "Enes")
// prints Hello Enes!

// a function with a return value
var arr = [1, 2, 3, 4, 5, 6]

func calculateArraySum(arr: [Int]) -> Int {
  var total = 0
  for value in arr {
    total += value
  }
  return total
}

print(calculateArraySum(arr: arr))
// prints 21

// a function omitting the argument label
// lets redefine calculateArraySum(arr:) function
// you need to put an underscore before the internal label following with a whitespace
func calculateArraySum(_ arr: [Int]) -> Int {
  var total = 0
  for value in arr {
    total += value
  }
  return total
}

// now we can call it omitting the argument label
print(calculateArraySum(arr))
// prints 21


// function parameters can also have default values
func takeExponentOf(num: Int, withPower: Int = 2) -> Int {
  if withPower == 1 { return num }
  return num * takeExponentOf(num: num, withPower: withPower - 1)
}
// the function above is a recursive function which calls itself by decreasing withPower by one until it reaches 1 which is the base case of our recursive function

// the iterative one
func takeExponentOf(num: Int, withPower: Int = 2) -> Int {
  var result = 1
  for _ in 0..<withPower {
    result *= num
  }
  return result
}

// 0..<withPower is defining a half open range that our function will execute withPower time
// if closed range is needed then it would be 0...withPower
// the reverse like withPower...0 or withPower..<0 won't work. The range must be incremental
// if reverse is needed there is a method called reverse() which would be like (0..<withPower).reversed()


print(takeExponentOf(num: 3))
// prints 9
print(takeExponentOf(num: 3, withPower: 3))
// prints 27

// BONUS: variadic parameters
// variadic parameters are given as Type... and it is interpreted as a collection of the given Type, in our case it is an Int
// you can iterate over numbers which is basically an [Int]
func countSum(numbers: Int...) -> Int {
  var total = 0
  for number in numbers {
    total += number
  }
  return total
}

// you give the parameters like an array seperated with commas
// giving an array won't work because it expects Int and you try to give an [Int] array. Try it yourself.
let total = countSum(numbers: 1, 2, 3, 4)
print("The total is \(total)")
// prints The total is 10

```

**If you want to learn more, visit the documentation [here](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html).**