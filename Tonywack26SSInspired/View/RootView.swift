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
            ProductView(viewModel: viewModel)

            if isLoading {
                LoadingView()
                    .transition(.opacity)
            }
        }
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
