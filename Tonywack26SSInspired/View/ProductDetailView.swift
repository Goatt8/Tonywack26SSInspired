//
//  ProductDetailView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/1/26.
//

import SwiftUI
import Kingfisher


struct ProductDetailView: View {
    
    @State private var currentIndex = 0
    
    let product: Product
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(Array(product.imageUrls.enumerated()), id: \.offset) { index, url in
                    KFImage(URL(string: url))
                        .placeholder { ProgressView() }
                        .retry(maxCount: 2, interval: .seconds(2))
                        .cacheMemoryOnly(false)
                        .fade(duration: 0.25)
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height * 0.65)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: UIScreen.main.bounds.height * 0.65)
            .offset(y: -30)
            .overlay(
                // custom Indicator
                VStack {
                       Spacer()
                       HStack(spacing: 6) {
                           ForEach(0..<product.imageUrls.count, id: \.self) { index in
                               Circle()
                                   .fill(index == currentIndex ? Color.black : Color.gray.opacity(0.4))
                                   .frame(width: 6, height: 6)
                           }
                       }
                       .padding(.bottom, 0)
                   }
            )
           
            // 상단 UI
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 44, height: 44)
                }
                .padding(.top, 50)
                .padding(.horizontal, 14)
                
                Spacer()
                
                // 하단 UI
                VStack(spacing: 6) {
                    Text(product.name)
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text("\(product.price) KRW")
                        .foregroundColor(.gray)
                    
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    
}
