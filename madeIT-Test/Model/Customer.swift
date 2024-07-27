import Foundation
import SwiftData

@Model
class Customer: Identifiable {
    var id: UUID
    var name: String
    var contactName: String
    var tel: String
    var email: String
    var industry: Industry
    var address: String
    var ressources: [Resource] = []
    
    init(name: String = "", 
         contactName: String = "",
         tel: String = "",
         email: String = "",
         industry: Industry = .undefined,
         address: String = "") {
        
        
        self.id = UUID()
        self.name = name
        self.contactName = contactName
        self.tel = tel
        self.email = email
        self.industry = industry
        self.address = address
    }
}

