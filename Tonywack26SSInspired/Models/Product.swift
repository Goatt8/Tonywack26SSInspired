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
