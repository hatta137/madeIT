//
//  Grafik.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 27.07.24.
//

import Foundation
import SwiftData

@Model
class Graphic: Identifiable {
    var name: String
    var notes: String
    var image: Data?
    var customer: Customer? // Optionaler Bezug auf Customer
    
    init(name: String, notes: String, image: Data? = nil, customer: Customer? = nil) {
        self.name = name
        self.notes = notes
        self.image = image
        self.customer = customer
    }
}
