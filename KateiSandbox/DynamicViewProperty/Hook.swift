//
//  Hook.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/23.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

import SwiftUI

let RTLD_DEFAULT = UnsafeMutableRawPointer(bitPattern: -2)
struct DVP_DispatchHookView: View, _View, Loggable {
    struct MyValue: Loggable {
        init() { logger.traceCall() }
    }
    let dynamicProperty = MyDynamicViewProperty()
    let unaryDynamicProperty = MyUnaryDynamicViewProperty()
    let objectBinding = ObjectBinding(initialValue: MyBindableObject())
    let stateValue = State(initialValue: MyValue())

    init() {
        logger.traceCall()
    }

    var body: some View {
        logger.traceCall()
        return Text("Hello")
    }

    // _ViewOutputsの初期化が出来ないのでコメントアウト
    // initの直後に呼ばれる
//    static func _makeView(view: _GraphValue<Self>, inputs: _ViewInputs) -> _ViewOutputs {
//        logger.traceCall()
//        fatalError()
//    }
    static func _makeViewList(view: _GraphValue<Self>, inputs: _ViewListInputs) -> _ViewListOutputs {
        logger.traceCall()
        fatalError()
    }
    static func _visitViewType<A1: _ViewTypeVisitor>(visitor: inout A1) {
        logger.traceCall()
    }
}


struct DVP_DispatchHook_ChildView: View, Loggable {
    let stateValue = State(initialValue: 1)
    var body: some View {
        logger.traceCall()
        return Text("World")
    }
    
    static func _makeView(view: _GraphValue<Self>, inputs: _ViewInputs) -> _ViewOutputs {
        logger.traceCall()
        fatalError()
    }
    static func _makeViewList(view: _GraphValue<Self>, inputs: _ViewListInputs) -> _ViewListOutputs {
        logger.traceCall()
        fatalError()
    }
    static func _visitViewType<A1: _ViewTypeVisitor>(visitor: inout A1) {
        logger.traceCall()
    }
}
