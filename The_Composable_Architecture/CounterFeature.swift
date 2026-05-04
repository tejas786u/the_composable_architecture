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
    struct State: Equatable {
        var count: Int = 0
        var isLoading: Bool = false
        var fact: String?
        var isTimerRunning: Bool = false
    }
    
    enum Action {
        case incrementButtonTapped
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    nonisolated enum CancelID {
        case timer
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    
    // 3. Confirm reduce func and map action with changing states
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true
            return .run { [count = state.count] send in
                try await send(.factResponse(self.numberFact.fetch(count)))
            }
        case .factResponse(let fact):
            state.fact = fact
            state.isLoading = false
            return .none
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            if state.isTimerRunning {
                return .run { send in
                    for await _ in await self.clock.timer(interval: .seconds(1)){
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        case .timerTick:
            state.count += 1
            state.fact = nil
            return .none
        }
    }
}

// 6. WithViewStore required equatable that's why added extesnion
//extension CounterFeature.State: Equatable {}
