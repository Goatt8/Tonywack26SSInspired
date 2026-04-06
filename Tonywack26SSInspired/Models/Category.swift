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
    
    var count: Int {
         switch self {
         case .outer: return 15
         case .knit: return 8
         case .top: return 11
         case .bottom: return 9
         case .acc: return 6
         }
     }
}
