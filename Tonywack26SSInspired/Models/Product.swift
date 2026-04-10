//
//  Product.swift
//  Tonywack26SSInspired
//
//  Created by goat on 3/31/26.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: String
    let name: String
    let price: Int
    let category: Category
    let imageUrls: [String]
}

//struct Product: Codable, Identifiable {
//    let id: String
//    let name: String
//    let price: Int
//    let imageUrls: [String]
//
//    private let categoryString: String
//    
//    var category: Category {
//        let normalized = categoryString
//            .trimmingCharacters(in: .whitespacesAndNewlines)
//            .lowercased()
//        
//        if let category = Category(rawValue: normalized) {
//            return category
//        } else {
//            print("❌ 잘못된 category:", categoryString)
//            return .outer
//        }
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, price, imageUrls
//        case categoryString = "category"
//    }
//}
