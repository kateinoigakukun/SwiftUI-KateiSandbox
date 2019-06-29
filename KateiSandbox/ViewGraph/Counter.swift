//
//  Counter.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/24.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

import SwiftUI

struct CounterView: View {
    var hidden = State(initialValue: true)
    
    var body: some View {
        print("render body")
        return VStack {
            if !hidden.value {
                CounterButton()
            }
            Toggle(isOn: hidden.binding) {
                Text("Hidden")
            }
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
    let prop = MyDynamicViewProperty()
    let state = State(initialValue: CounterState(count: 0))
    init() {
        print("Init button")
    }

    var body: some View {
        print("Button.body with \(state.value.count)")
        return VStack {
            Text(state.value.count.description)
            Button(action: {
                self.state.value.count += 1
            }) {
                Text("+")
            }
        }
    }
    static func _makeView(view: _GraphValue<Self>, inputs: _ViewInputs) -> _ViewOutputs {
        logger.traceCall()
        fatalError()
    }
}
