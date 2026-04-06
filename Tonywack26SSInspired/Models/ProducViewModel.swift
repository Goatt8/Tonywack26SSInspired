//
//  ProducViewModel.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/6/26.
//

import Foundation
import FirebaseFirestore

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    private let db = Firestore.firestore()
    
    func fetchProducts() {
        db.collection("products").getDocuments { snapshot, error in
            
            if let error = error {
                print("❌ Firestore 에러:", error)
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.products = documents.compactMap { doc in
                try? doc.data(as: Product.self)
            }
        }
    }
}
