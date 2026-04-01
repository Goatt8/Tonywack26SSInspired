//
//  ContentView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 3/31/26.
//

import SwiftUI

struct ProductView: View {
    
    let products: [Product] = [
        Product(id: "1", name: "Look_01", price: 89000, imageName: "look_01", category: "outer"),
        Product(id: "2", name: "Look_02", price: 79000, imageName: "look_02", category: "outer"),
        Product(id: "3", name: ":Look_03", price: 69000, imageName: "look_03", category: "outer"),
        Product(id: "4", name: "Look_04", price: 79000, imageName: "look_04", category: "outer"),
        Product(id: "5", name: "Look_05", price: 79000, imageName: "look_05", category: "outer"),
        Product(id: "6", name: "Look_06", price: 79000, imageName: "look_06", category: "outer"),
        Product(id: "7", name: "Look_07", price: 79000, imageName: "look_07", category: "outer"),
        Product(id: "8", name: "Look_08", price: 79000, imageName: "look_08", category: "outer")
    ]
    
    @State private var selectedIndex: Int = 0
    
    var visibleRange: ClosedRange<Int> {
        let lower = max(0, selectedIndex - 2)
        let upper = min(products.count - 1, selectedIndex + 2)
        return lower...upper
    }
    
    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(products.indices, id: \.self) { index in
                        Image(products[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    }
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 26) {
                    ForEach(products.indices, id: \.self) { index in
                        
                        if visibleRange.contains(index) {
                            
                            Text(products[index].name)
                                .foregroundColor(index == selectedIndex ? .black : .gray)
                                .font(index == selectedIndex ? .headline : .subheadline)
                                .scaleEffect(index == selectedIndex ? 1.1 : 0.95)
                                .opacity(index == selectedIndex ? 1 : 0.8)
                                .animation(.easeInOut(duration: 0.2), value: selectedIndex)
                                .onTapGesture {
                                    selectedIndex = index
                                }
                        }
                    }
                }
                .padding(.leading, 20)
                
                Spacer()
            }
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding(.top, 4)
                
                Spacer()
            }
        }
    }
}


#Preview {
    ProductView()
}
