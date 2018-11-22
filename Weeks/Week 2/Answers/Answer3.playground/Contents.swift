import Foundation

extension String {
  func encrypt(shift: Int) -> String {
    let cipheredText = self.unicodeScalars.map { unicodeScalar -> Character in
      let shiftedValue = (Int(unicodeScalar.value) + shift)
      return Character(Unicode.Scalar(shiftedValue)!)
    }
    return String(cipheredText)
  }
  
  func decrypt(shift: Int) -> String {
    let cipheredText = self.unicodeScalars.map { unicodeScalar -> Character in
      let shiftedValue = (Int(unicodeScalar.value) - shift)
      return Character(Unicode.Scalar(shiftedValue)!)
    }
    return String(cipheredText)
  }
}


let textToEncrypt = "Hello"
let shiftValue = 10
print("Text to be encrypted: \(textToEncrypt)")
let encryptedText = textToEncrypt.encrypt(shift: shiftValue)
print("Encrypted: \(encryptedText)")
let decryptedText = encryptedText.decrypt(shift: shiftValue)
print("Decrypted: \(decryptedText)")



