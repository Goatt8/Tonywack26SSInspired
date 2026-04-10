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
        didSet { applyFilters() }
    }

    @Published var searchText: String = "" {
        didSet { applyFilters() }
    }

    @Published var minPrice: Double = 0 {
        didSet { applyFilters() }
    }

    @Published var maxPrice: Double = 1000000 {
        didSet { applyFilters() }
    }
    
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
        
        print("현재 선택:", selectedCategory)
        print("전체 카테고리:", products.map { $0.category })
  
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
        print("\(self.selectedCategory)")
        print("\(self.filteredProducts)")
    }
    
}
