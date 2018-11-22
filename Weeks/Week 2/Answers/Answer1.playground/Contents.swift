protocol QueueProtocol {
  associatedtype T
  var isEmpty: Bool { get }
  var container: [T] { get }
  var count: Int { get }
}

class Queue<T>: QueueProtocol {
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
  
  func enqueue(item: T) {
    container.insert(item, at: 0)
  }
  
  func dequeue() -> T? {
    return container.popLast()
  }
  
  func getItems() -> [T] {
    return container
  }
  
  func showItems() {
    for item in container {
      print(item, terminator: " ")
    }
    print("")
  }
}

let myQueue = Queue<Int>()

for item in 0...10 {
  myQueue.enqueue(item: item)
}

print("Myqueue contains \(myQueue.count) elements.")
myQueue.showItems()

while !myQueue.isEmpty {
  print(myQueue.dequeue()!)
}

print("Myqueue contains \(myQueue.count) elements after dequeueing.")


