//
//  ContentView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 3/31/26.
//

import SwiftUI
import Kingfisher


struct ProductView: View {
    
    @State private var selectedIndex: Int = 0
    
    @State private var selectedProduct: Product? = nil
    
    @State private var isMenuOpen: Bool = false
    @State private var isSearchOpen: Bool = false
    
    @StateObject private var viewModel = ProductViewModel()
    
    var visibleRange: ClosedRange<Int> {
        guard !viewModel.filteredProducts.isEmpty else { return 0...0 }
        
        let lower = max(0, selectedIndex - 2)
        let upper = min(viewModel.filteredProducts.count - 1, selectedIndex + 2)
        
        return lower <= upper ? lower...upper : lower...lower
    }
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(viewModel.filteredProducts.enumerated()), id: \.element.id) { index, product in
                        
                        let imageUrl = product.imageUrls.first ?? ""
                        
                        KFImage(URL(string: imageUrl))
                            .placeholder {
                                ProgressView()
                            }
                            .retry(maxCount: 2, interval: .seconds(2))
                            .cacheMemoryOnly(false)
                            .fade(duration: 0.25)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 540)
                            .clipped()
                            .blur(radius: index == selectedIndex ? 0 : 1.7)
                            .opacity(index == selectedIndex ? 1 : 0.9)
                            .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                            .onTapGesture {
                                selectedProduct = product
                            }
                            .background(
                                GeometryReader { geo in
                                    Color.clear.preference(
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
                    ForEach(viewModel.filteredProducts.indices, id: \.self) { index in
                        
                        if visibleRange.contains(index) {
                            Text(viewModel.filteredProducts[index].id)
                                .foregroundColor(index == selectedIndex ? .black : .gray)
                                .font(index == selectedIndex ? .headline : .subheadline)
                                .scaleEffect(index == selectedIndex ? 1.1 : 0.9)
                                .opacity(index == selectedIndex ? 1 : 0.7)
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
                    selectedCategory: $viewModel.selectedCategory,
                    isMenuOpen: $isMenuOpen
                )
                .frame(width: 300)
                .offset(x: isMenuOpen ? 0 : -300)
                
            }
            .onChange(of: viewModel.selectedCategory) {
                selectedIndex = 0
            }
            
            ZStack(alignment: .trailing) {
                Color.black.opacity(isSearchOpen ? 0.4 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isSearchOpen = false
                        }
                    }

                SearchView(
                    searchText: $viewModel.searchText,
                    minPrice: $viewModel.minPrice,
                    maxPrice: $viewModel.maxPrice,
                    isOpen: $isSearchOpen
                )
                .frame(width: 300)
                .offset(x: isSearchOpen ? 0 : 300)
            }
            
            VStack {
                HStack {
                    // 메뉴버튼
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
                    // 검색버튼
                    Button {
                        withAnimation {
                            isSearchOpen.toggle()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                .padding(.top, 10)
                Spacer()
            }
            .fullScreenCover(item: $selectedProduct) { product in
                ProductDetailView(product: product)
            }
        }
        .animation(.easeInOut, value: isMenuOpen)
        .onAppear {
            viewModel.fetchProducts()
        }
    }
    
}

#Preview {
    ProductView()
}
