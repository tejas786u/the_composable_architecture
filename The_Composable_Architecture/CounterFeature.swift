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

struct CounterView: View {
    // 4. create constan of type StoreOf
        let store: StoreOf<CounterFeature>
    
    var body: some View {
        // 5. Observe changes and catch inside the viewStore and update values in View
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                HStack {
                    Button("-") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
    }
}
// 6. WithViewStore required equatable that's why added extesnion
extension CounterFeature.State: Equatable {}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}
