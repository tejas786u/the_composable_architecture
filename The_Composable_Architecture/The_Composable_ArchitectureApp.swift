//
//  The_Composable_ArchitectureApp.swift
//  The_Composable_Architecture
//
//  Created by Tejas Patel on 03/05/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct The_Composable_ArchitectureApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: The_Composable_ArchitectureApp.store)
        }
    }
}
