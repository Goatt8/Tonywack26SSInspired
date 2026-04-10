//
//  ProducViewModel.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/6/26.
//

import Foundation
import FirebaseFirestore

@MainActor
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
    
    func fetchProductsData() async {
           do {
               let snapshot = try await db.collection("products").getDocuments()
               
               self.products = snapshot.documents.compactMap {
                   try? $0.data(as: Product.self)
               }
               
               self.applyFilters()
               
           } catch {
               print("fetchProductsData 에러")
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
