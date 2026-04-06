//
//  ProductDetailView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/1/26.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(product.name)
                .resizable()
                .scaledToFill()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
                .blur(radius: 10)
                .clipped()
                .ignoresSafeArea()
            
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                HStack{
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
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
                .padding(.top, -60)
                .padding(.horizontal, 14)
                
                Image(product.name)
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height * 0.65)
                    .clipped()
                
                VStack(spacing: 8) {
                    
                    Text(product.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    Text("\(product.price) 원")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}


#Preview {
    ProductDetailView(
        product: Product(
            id: "1",
            name: "VELVET ZIPPERED BLOUSON JACKET_ DARK BROWN",
            price: 89000,
            category: .outer,
            imageUrls: []
        )
    )
}
