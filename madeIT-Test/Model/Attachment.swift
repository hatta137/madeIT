//
//  Grafik.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 27.07.24.
//

import Foundation
import SwiftData

@Model
class Attachment: Identifiable {
    var name: String
    var notes: String
    var attachmentData: Data?
    var customer: Customer? // Optionaler Bezug auf Customer
    
    init(name: String, notes: String, attachmentData: Data? = nil, customer: Customer? = nil) {
        self.name = name
        self.notes = notes
        self.attachmentData = attachmentData
        self.customer = customer
    }
}
