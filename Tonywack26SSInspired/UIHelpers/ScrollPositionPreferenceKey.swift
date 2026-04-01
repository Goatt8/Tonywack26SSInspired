//
//  ScrollOffsetKey.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/1/26.
//

import SwiftUI

struct ScrollPositionPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
