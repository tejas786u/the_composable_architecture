//
//  CounterFeature.swift
//  The_Composable_Architecture
//
//  Created by Tejas Patel on 03/05/26.
//

import SwiftUI
import ComposableArchitecture

// 1. Make it conform of Reducer
struct CounterFeature: Reducer {
    // 2. Add stubs Struct State and enum Action
    struct State {
        var count: Int = 0
    }
    
    enum Action {
        case incrementButtonTapped
        case decrementButtonTapped
    }
    
    // 3. Confirm reduce func and map action with changing states
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .incrementButtonTapped:
            state.count += 1
            return .none
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        }
    }
}

// 6. WithViewStore required equatable that's why added extesnion
extension CounterFeature.State: Equatable {}
