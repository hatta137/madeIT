//
//  TypeOfRessource.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import Foundation

enum TypeOfRessource: String, Codable, Identifiable, CaseIterable {
    
    var id: String { rawValue }
    
    case undefined = "undefiniert"
    case server = "Server"
    case pc = "PC"
    case storage = "Storage"
    case vm = "VM"
    case router = "Router"
    case firewall = "Firewall"
    case networkSwitch = "Network Switch"
    case usv = "USV"
    case website = "Website"
    case license = "Lizenz"
}
