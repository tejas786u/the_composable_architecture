//
//  ContentView.swift
//  The_Composable_Architecture
//
//  Created by Tejas Patel on 03/05/26.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    // 4. create constan of type StoreOf
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        // 5. Observe changes and catch inside the viewStore and update values in View
        WithViewStore(store, observe: { $0 }) { viewStore in
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
                    Button(viewStore.isTimerRunning ? "Stop Timer" : "Start Timer") {
                        viewStore.send(.toggleTimerButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
                Button("Fact") {
                    viewStore.send(.factButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                if viewStore.isLoading {
                    ProgressView()
                } else if let fact = viewStore.fact{
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView(store: Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}
