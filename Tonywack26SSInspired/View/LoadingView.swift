//
//  HomeView.swift
//  Tonywack26SSInspired
//
//  Created by goat on 4/1/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)

                ProgressView()
                    .scaleEffect(1.2)
            }
        }
    }
}
