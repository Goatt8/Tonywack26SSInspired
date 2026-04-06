//
//  ProductDetailView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/1/26.
//

import SwiftUI
import Kingfisher


struct ProductDetailView: View {
    
    let product: Product
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            TabView {
                ForEach(product.imageUrls, id: \.self) { url in
                    KFImage(URL(string: url))
                        .placeholder { ProgressView() }
                        .retry(maxCount: 2, interval: .seconds(2))
                        .cacheMemoryOnly(false)
                        .fade(duration: 0.25)
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.height * 0.7)
                        .clipped()
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.7)
            .tabViewStyle(.page)
            .offset(y: -20)
        
            
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
                    
                    Text("\(product.price) 원")
                        .foregroundColor(.gray)
                        
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
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
            imageUrls: ["https://firebasestorage.googleapis.com/v0/b/tonywack26ssinspired.firebasestorage.app/o/outer_1%2Fouter_01_01.jpg?alt=media&token=63981c22-3769-460d-bbf4-24aa901d387a","https://firebasestorage.googleapis.com/v0/b/tonywack26ssinspired.firebasestorage.app/o/outer_1%2Fouter_01_02.jpg?alt=media&token=b38ada73-4384-43c3-ae59-86599d89a79e"]
        )
    )
}
