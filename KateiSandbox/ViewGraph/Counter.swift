//
//  Counter.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/24.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

import SwiftUI

struct CounterView: View {
    
    var counter = State<Int>(initialValue: 0)
    var hidden = State(initialValue: true)
    
    var body: some View {
        print("render body")
        return VStack {
            //Text(counter.value.description)
            //if !hidden.value {
                CounterButton(
                    state: 0,//counter.value,
                    newValue: { _ in
//                        print("before update: \(self.counter.value), input: \($0)")
//                        self.counter.value = $0 + 1
//                        print("after update: \(self.counter.value)")
                })
//            }
//            Toggle(isOn: hidden.binding) {
//                Text("Hidden")
//            }
        }
    }
}

struct CounterState {
    var count: Int
    init(count: Int) {
        self.count = count
    }
}

struct CounterButton: View, Loggable {
    let state: State<CounterState>
    let prop = MyDynamicViewProperty()
    let newValueHandler: (Int) -> Void
    init(state: Int, newValue: @escaping (Int) -> Void) {
        self.state = State(initialValue: CounterState(count: state))
        self.newValueHandler = newValue
        print("Init with \(state)")
    }

    var body: some View {
        print("body with \(state.value.count)")
        return VStack {
            Button(action: {
            self.state.value.count += 1
//            self.newValueHandler(self.state.value.count)
        }) {
            Text("+")
        }
            Text("local: \(self.state.value.count)")
        }
    }
    static func _makeView(view: _GraphValue<Self>, inputs: _ViewInputs) -> _ViewOutputs {
        logger.traceCall()
        fatalError()
    }
}
