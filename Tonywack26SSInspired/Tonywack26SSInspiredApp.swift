//
//  Tonywack26SSInspiredApp.swift
//  Tonywack26SSInspired
//
//  Created by goat on 3/31/26.
//

import SwiftUI
import Firebase

@main
struct Tonywack26SSInspiredApp: App {
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
