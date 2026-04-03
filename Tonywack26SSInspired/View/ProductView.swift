//
//  ContentView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 3/31/26.
//

import SwiftUI

struct ProductView: View {
    
    @State private var selectedIndex: Int = 0
    
    @State private var selectedProduct: Product? = nil
    
    @State private var selectedCategory: Category = .outer
    
    @State private var isMenuOpen: Bool = false
    
    var products: [Product] {
        Product.testData
    }
    
    var filteredProducts: [Product] {
        products.filter { $0.category == selectedCategory }
    }
    
    var visibleRange: ClosedRange<Int> {
        guard !filteredProducts.isEmpty else { return 0...0 }
        
        let lower = max(0, selectedIndex - 2)
        let upper = min(filteredProducts.count - 1, selectedIndex + 2)
        
        return lower <= upper ? lower...upper : lower...lower
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredProducts.indices, id: \.self) { index in
                        Image(filteredProducts[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 540)
                            .clipped()
                            .blur(radius: index == selectedIndex ? 0 : 1.5)
                            .opacity(index == selectedIndex ? 1 : 0.9)
                            .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                            .onTapGesture {
                                selectedProduct = filteredProducts[index]
                            }
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .preference(
                                            key: ScrollPositionPreferenceKey.self,
                                            value: [index: geo.frame(in: .global).midY]
                                        )
                                }
                            )
                    }
                }
            }
            
            .onPreferenceChange(ScrollPositionPreferenceKey.self) { values in
                
                let screenCenter = UIScreen.main.bounds.height / 2
                let closest = values.min(by: { abs($0.value - screenCenter) < abs($1.value - screenCenter) })
                
                if let index = closest?.key {
                    selectedIndex = index
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 26) {
                    ForEach(filteredProducts.indices, id: \.self) { index in
                        
                        if visibleRange.contains(index) {
                            Text(filteredProducts[index].name)
                                .foregroundColor(index == selectedIndex ? .black : .gray)
                                .font(index == selectedIndex ? .headline : .subheadline)
                                .scaleEffect(index == selectedIndex ? 1.1 : 0.9)
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
            
            //MenuView
            ZStack(alignment: .leading) {
                Color.black.opacity(isMenuOpen ? 0.4 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen = false
                        }
                    }
                
                MenuView(
                    selectedCategory: $selectedCategory,
                    isMenuOpen: $isMenuOpen
                )
                .frame(width: 300)
                .offset(x: isMenuOpen ? 0 : -300)
                
            }
            .onChange(of: selectedCategory) {
                selectedIndex = 0
            }
            
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                    Spacer()
                    
                    // 네비게이션 우측 빈 공간
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 44, height: 44)
                }
                .padding(.top, 10)
                Spacer()
            }
            .fullScreenCover(item: $selectedProduct) { product in
                ProductDetailView(product: product)
            }
        }
        .animation(.easeInOut, value: isMenuOpen)
    }
}

#Preview {
    ProductView()
}
