//
//  RootView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/10/26.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            if isLoading {
                LoadingView()
                    .opacity(isLoading ? 1 : 0)
            } else {
                ProductView(viewModel: viewModel)
                    .opacity(isLoading ? 0 : 1)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: isLoading)
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        Task {
            await viewModel.fetchProductsData()
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            isLoading = false
        }
    }
}
