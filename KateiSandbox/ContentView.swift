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
    var body: some View {
        NavigationView {
            List {
                NavigationButton(destination: DVP_Fields_View()) {
                    Text("DVP Fields")
                }
            }
            .navigationBarTitle(Text("KateiSandbox"))
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
