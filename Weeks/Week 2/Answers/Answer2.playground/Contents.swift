
// A prtocol for the general variables for PublicTransport
// notice that all variables are only gettable not settable
protocol PublicTransportProperties {
  var maxSpeed: Double { get }
  var capacity: Int { get }
  var currentSpeed: Double { get }
  var currentPassengers: Int { get }
  var lineName: String { get }
  var description: String { get }
}

// The general public transportation class
class PublicTransport: PublicTransportProperties {
  var maxSpeed: Double
  var capacity: Int
  var currentSpeed: Double
  var currentPassengers: Int
  var lineName: String
  
  var description: String {
    return "I am a public transport"
  }
  
  init(lineName: String, capacity: Int, maxSpeed: Double) {
    self.lineName = lineName
    self.capacity = capacity
    self.maxSpeed = maxSpeed
    self.currentSpeed = 0
    self.currentPassengers = 0
  }
  
  func move(withSpeed: Double) {
    if withSpeed > maxSpeed {
      print("Cannot set speed higher than \(maxSpeed)")
    } else {
      self.currentSpeed = withSpeed
    }
    
  }
  
  func increaseSpeed(by speed: Double = 0.5) {
    if speed + currentSpeed > maxSpeed {
      print("Cannot set speed higher than \(maxSpeed)")
    } else {
      self.currentSpeed += speed
    }
  }
  
  func loadPassengers(amount: Int) {
    if currentPassengers + amount > capacity {
      let canGet = capacity - currentPassengers
      print("Cannot get all pasengers. Only \(canGet) passenger can be loaded.")
      currentPassengers += canGet
      print("\(canGet) passenger loaded.")
    } else {
      currentPassengers += amount
      print("All passengers loaded.")
    }
  }
  
  func removePassenders(amount: Int) {
    if amount > currentPassengers {
      print("\(amount) passengers cannot be removed. There are \(currentPassengers) passengers onboard.")
    } else {
      currentPassengers -= amount
    }
  }
  
  func stop() {
    self.currentSpeed = 0
  }
  
  func honk() {
    print("Daaaaat!")
  }
  
}

class Airplane: PublicTransport {
  
  override var description: String {
    return "I am an airplane with line: \(lineName)"
  }
  
  override init(lineName: String, capacity: Int, maxSpeed: Double) {
    super.init(lineName: lineName, capacity: capacity, maxSpeed: maxSpeed)
  }

  
  override func honk() {
    print("Zaaaat!")
  }
  
}

class Bus: PublicTransport {
  
  override var description: String {
    return "I am a bus with line: \(lineName)"
  }

  override init(lineName: String, capacity: Int, maxSpeed: Double) {
    super.init(lineName: lineName, capacity: capacity, maxSpeed: maxSpeed)
  }
  
  override func honk() {
    print("Zonnnkkkk!")
  }
}

class Metro: PublicTransport {
  
  override var description: String {
    return "I am a metro with line: \(lineName)"
  }
  
  override init(lineName: String, capacity: Int, maxSpeed: Double) {
    super.init(lineName: lineName, capacity: capacity, maxSpeed: maxSpeed)
  }
  
  override func honk() {
    print("Guuuut!")
  }
}

let metro = Metro(lineName: "M1", capacity: 100, maxSpeed: 100)
metro.increaseSpeed(by: 50)
print("\(metro.description) and my current speed is \(metro.currentSpeed)")



let bus = Bus(lineName: "500T", capacity: 60, maxSpeed: 80)
bus.increaseSpeed(by: 70)
bus.honk()
bus.stop()
print("\(bus.description) and my current speed is \(bus.currentSpeed)")



let airplane = Airplane(lineName: "IST-JFK", capacity: 300, maxSpeed: 1000)
print(airplane.description)
airplane.loadPassengers(amount: 299)
print(airplane.currentPassengers)
airplane.loadPassengers(amount: 2)
print(airplane.currentPassengers)
airplane.removePassenders(amount: 300)
print(airplane.currentPassengers)
airplane.loadPassengers(amount: 250)
airplane.increaseSpeed(by: 950)
print("\(airplane.description) and my current speed is \(airplane.currentSpeed)")
