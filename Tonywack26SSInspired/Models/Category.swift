//
//  Category.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/2/26.
//

import Foundation

enum Category: String, CaseIterable {
    case outer
    case knitwear
    case topAndShirts
    case bottom
    case acc
    
    var title: String {
        rawValue.capitalized
    }
}
