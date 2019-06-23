//
//  ContentView.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/23.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView : View {
    init() {
        print(DVP_DispatchHookView.Body.self)
    }
    var body: some View {
        NavigationView {
            List {
                NavigationButton(destination: DVP_Fields_View()) {
                    Text("DVP Fields")
                }
                NavigationButton(destination: DVP_DispatchHookView().environmentObject(PureBindableObject())) {
                    Text("DVP Dispatch Hook")
                }
                NavigationButton(destination: CounterView()) {
                    Text("Counter")
                }
            }
            .navigationBarTitle(Text("KateiSandbox"))
        }
    }
    
    func is__LegacyView<T: __LegacyView>(_ type: T.Type) {
        isView(type)
    }
    func isView<T: View>(_ type: T.Type) {
    }
    
    
}

struct CounterView: View {
    
    var counter = State<Int>(initialValue: 0)
    
    var body: some View {
        VStack {
            Text(counter.value.description)
            Button(action: { self.counter.value += 1 }) {
                Text("+")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
