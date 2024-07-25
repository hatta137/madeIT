//
//  Ressource.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//


import Foundation
import SwiftData

@Model
class Ressource: Identifiable {
    var id: UUID
    var name: String
    // var typeOfRessource: TypeOfRessource
    var notes: String
    var ip: String
    var url: String
    var userName: String
    var password: String
    
    init(name: String = "", notes: String = "", ip: String = "", url: String = "", userName: String = "", password: String = "") {
        self.id = UUID()
        self.name = name
//        self.typeOfRessource = typeOfRessource
        self.notes = notes
        self.ip = ip
        self.url = url
        self.userName = userName
        self.password = password
    }
}

//struct MockDataResssource {
//    static let sampleRessource  = Ressource(id: UUID(), name: "Hyper V", typeOfRessource: .server, description: "Host System für Virtualisierung", ip: "10.10.1.100", url: "hyperv.local", userName: "administrator", password: "admin123")
//    static let sampleRessource2 = Ressource(id: UUID(), name: "NAS", typeOfRessource: .storage, description: "Netzwerkspeicher für Backups", ip: "10.10.1.101", url: "synnas.local", userName: "admin", password: "admin123")
//    static let sampleRessource3 = Ressource(id: UUID(), name: "Hyper V - Lizenz", typeOfRessource: .server, description: "Lizenz für Hostsystem und VMs", ip: "", url: "also.com", userName: "", password: "WERD-WFEFR-FWEFY-FWEF-DF")
//    static let sampleRessource4 = Ressource(id: UUID(), name: "Macbook Pro Hendrik", typeOfRessource: .pc, description: "Firmennotebook", ip: "", url: "", userName: "hendrik", password: "admin123")
//    static let sampleRessource5 = Ressource(id: UUID(), name: "Fritz Box", typeOfRessource: .router, description: "Internetzugang", ip: "10.10.1.1", url: "fritz.box", userName: "administrator", password: "admin123")
//    
//    static let sampleRessources = [sampleRessource, sampleRessource2, sampleRessource3, sampleRessource4, sampleRessource5]
//    
//}
