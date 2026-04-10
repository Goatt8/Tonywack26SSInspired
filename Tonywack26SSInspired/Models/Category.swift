//
//  Category.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/2/26.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case outer
    case knit
    case top
    case bottom
    case acc
    
    var title: String {
        rawValue.capitalized
    }
}
