//
//  MenuView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/1/26.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var selectedCategory: Category
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 18) {
                
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.title)
                        .font(.title3)
                        .foregroundColor(selectedCategory == category ? .black : .gray)
                        .onTapGesture {
                            selectedCategory = category
                            isMenuOpen = false
                        }
                }
                Spacer()
            }
            .padding(.top, 100)
            .padding(.leading, 20)
        }
    }
}
