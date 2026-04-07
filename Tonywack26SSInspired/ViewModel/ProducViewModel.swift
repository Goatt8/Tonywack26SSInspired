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
    @Published var filteredProducts: [Product] = []

    @Published var selectedCategory: Category = .outer {
        didSet {
            self.applyFilters()
        }
    }
    @Published var searchText: String = ""
    @Published var minPrice: Double = 0
    @Published var maxPrice: Double = 1000000
    
    private let db = Firestore.firestore()
    
    func fetchProducts() {
        db.collection("products").getDocuments { snapshot, error in
            
            if let error = error {
                print("fetchProducts 에러:", error)
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.products = documents.compactMap { doc in
                try? doc.data(as: Product.self)
            }
            self.applyFilters()
        }
    }
    
    func applyFilters() {
        var result = products
  
        result = result.filter { $0.category == selectedCategory }
        
        if !searchText.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    
        result = result.filter {
            $0.price >= Int(minPrice) && $0.price <= Int(maxPrice)
        }
        filteredProducts = result
    }
    
}
