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
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                }
                
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                
                Text(product.name)
                    .font(.title)
                    .bold()
                
                Text("\(product.price)원")
                    .font(.headline)
                
                Text("이 상품은 룩북 기반의 스타일 아이템입니다.")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

#Preview {
    ProductDetailView(
        product: Product(
            id: "1",
            name: "Look_01",
            price: 89000,
            imageName: "look_01",
            category: .outer
        )
    )
}
