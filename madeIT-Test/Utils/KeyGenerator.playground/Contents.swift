import CryptoKit
import Foundation

// Generieren eines neuen symmetrischen Schlüssels
let newKey = SymmetricKey(size: .bits256)

// Base64-kodierter String des Schlüssels
let keyData = newKey.withUnsafeBytes { Data(Array($0)) }
let base64KeyString = keyData.base64EncodedString()

print("New Base64 Key String: \(base64KeyString)")
