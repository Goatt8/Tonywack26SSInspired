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

//extension Product {
//    
//    static let priceDict: [Int: Int] = [
//        1: 89000,
//        2: 79000,
//        3: 69000,
//        4: 79000
//    ]
//    
//    static let testData: [Product] = Category.allCases.flatMap { category in
//        (1...category.count).map { i in
//            Product(
//                id: "\(category)_\(i)",
//                name: "\(category)_\(String(format: "%02d", i))",
//                price: priceDict[i] ?? 79000,
//                imageName: "\(category)_\(String(format: "%02d", i))",
//                category: category
//            )
//        }
//    }
//}

