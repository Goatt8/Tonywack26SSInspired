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
        Product(id: "2", name: "Look_02", price: 79000, imageName: "look_02", category: "top"),
        Product(id: "3", name: ":Look_03", price: 69000, imageName: "look_03", category: "bottom")
    ]
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
//            Color.black.ignoresSafeArea()
            TabView(selection: $selectedIndex) {
                ForEach(products.indices, id: \.self) { index in
                    Image(products[index].imageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(products.indices, id: \.self) { index in
                        Text(products[index].name)
                            .foregroundColor(index == selectedIndex ? .white : .gray)
                            .font(.headline)
                            .onTapGesture {
                                selectedIndex = index
                            }
                    }
                }
                .padding(.leading, 20)
                
                Spacer()
            }
        }
    }
}


#Preview {
    ProductView()
}
