import CryptoKit
import Foundation

class CryptoHelper {
    
    private static let keyString = "xULpcaTwYFPeN7TBIVhHM0fwhEyaHgRth8g/VToFPOg="
    
    private static let symmetricKey: SymmetricKey = {
        guard let data = Data(base64Encoded: keyString) else {
            fatalError("Invalid Base64 key string.")
        }
        return SymmetricKey(data: data)
    }()
    
    static func encrypt(_ plaintext: String) -> String? {
        guard let plaintextData = plaintext.data(using: .utf8) else { return nil }
        do {
            let sealedBox = try AES.GCM.seal(plaintextData, using: symmetricKey)
            print(sealedBox.combined?.base64EncodedString() as Any)
            return sealedBox.combined?.base64EncodedString()
        } catch {
            print("Error encrypting data: \(error)")
            return nil
        }
    }

    static func decrypt(_ encryptedText: String) -> String? {
        guard let encryptedData = Data(base64Encoded: encryptedText) else { return nil }
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            print(String(data: decryptedData, encoding: .utf8) as Any)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Error decrypting data: \(error.localizedDescription)")
            return nil
        }
    }
}
