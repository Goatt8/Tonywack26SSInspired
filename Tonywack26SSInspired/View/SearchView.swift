//
//  SearchView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/7/26.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchText: String
    @Binding var minPrice: Double
    @Binding var maxPrice: Double
    @Binding var isOpen: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            
            TextField("Search", text: $searchText)
                .textFieldStyle(.roundedBorder)
            
            Text("Price")
            
            Slider(value: $minPrice, in: 0...1000000)
            Slider(value: $maxPrice, in: 0...1000000)
            
            Text("\(Int(minPrice)) - \(Int(maxPrice))원")
                      .font(.subheadline)
                      .foregroundColor(.gray)
            
            Button("Reset") {
                searchText = ""
                minPrice = 0
                maxPrice = 1000000
            }
            
            Spacer()
        }
        .padding(.top, 90)
        .padding(.horizontal, 16)
        .background(Color.white)
    }
}


