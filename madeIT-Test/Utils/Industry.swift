//
//  Industry.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 25.07.24.
//
import Foundation

enum Industry: String, Codable, Identifiable, CaseIterable {
    
    var id: String { rawValue }
    
    case undefined = "undefiniert"
    case it = "IT"
    case construction = "Baugewerbe"
    case trade = "Handel"
    case farming = "Landwirtschaft"
    case crafts = "Handwerk"
    case industry = "Industrie"
    case business = "Gewerbe"
    case healthcare = "Medizin"
    case music = "Musik"
    case government = "Staat"
}
