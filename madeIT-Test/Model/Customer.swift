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
    var ressources: [Ressource] = [] // Liste von Ressourcen
    
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

//struct MockData {
//    static let sampleCustomer = Customer(
//        id: UUID(),
//        name: "HL Webdev",
//        contactName: "Hendrik Lendeckel",
//        tel: "0156140244595",
//        email: "test@test.de",
//        industry: "Webentwicklung",
//        address: "Kurt Beate Straße, 9 99086 Erfurt",
//        ressources: [MockDataResssource.sampleRessource, MockDataResssource.sampleRessource2]
//    )
//    
//    static let sampleCustomer2 = Customer(
//        id: UUID(),
//        name: "Hanna Innendesign",
//        contactName: "Hanna Gunkel",
//        tel: "0156140244595",
//        email: "test@test.de",
//        industry: "Innenarchitektur",
//        address: "Kurt Beate Straße, 9 99086 Erfurt",
//        ressources: [MockDataResssource.sampleRessource3]
//    )
//    
//    static let sampleCustomer3 = Customer(
//        id: UUID(),
//        name: "Gunkel Transporte",
//        contactName: "Matthias Gunkel",
//        tel: "0156140244595",
//        email: "test@test.de",
//        industry: "Baustoffhandel",
//        address: "Kurt Beate Straße, 9 99086 Erfurt",
//        ressources: []
//    )
//    
//    static let customers = [sampleCustomer, sampleCustomer2, sampleCustomer3]
//}
