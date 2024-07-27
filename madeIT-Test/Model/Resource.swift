//
//  Ressource.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//


import Foundation
import SwiftData

@Model
class Resource: Identifiable {
    var id: UUID
    var name: String
    var typeOfRessource: TypeOfResource
    var notes: String
    var ip: String
    var url: String
    var customer: Customer? // Optionaler Bezug auf Customer
    var userName: String
    private var encryptedPassword: String

    init(name: String = "",
         typeOfRessource: TypeOfResource = .undefined,
         notes: String = "",
         ip: String = "",
         url: String = "",
         customer: Customer? = nil,
         userName: String = "",
         password: String = "") {
        
        self.id = UUID()
        self.name = name
        self.typeOfRessource = typeOfRessource
        self.notes = notes
        self.ip = ip
        self.url = url
        self.customer = customer
        self.userName = userName
        self.encryptedPassword = CryptoHelper.encrypt(password) ?? ""
    }
    
    func getPassword() -> String? {
        return CryptoHelper.decrypt(encryptedPassword)
    }
    
    func setPassword(_ newPassword: String) {
        encryptedPassword = CryptoHelper.encrypt(newPassword) ?? ""
    }
}
