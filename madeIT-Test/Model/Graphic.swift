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
    
    init(name: String, notes: String, image: Data? = nil) {
        self.name = name
        self.notes = notes
        self.image = image
    }
}
