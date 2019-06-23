//
//  Type.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/23.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

import Combine
import SwiftUI

class MyDynamicViewProperty: DynamicViewProperty, Loggable {

    func update() {
        logger.traceCall()
    }
    
    static var _isUnary: Bool {
        logger.traceCall()
        return false
    }
    
    static func _makeLink<A>(in buffer: inout _DynamicViewPropertyBuffer, container: _GraphValue<A>, linkOffset: Int, inputs: inout _ViewInputs) -> () {
        logger.traceCall()
    }
}

class MyUnaryDynamicViewProperty: DynamicViewProperty, Loggable {
    
    func update() {
        logger.traceCall()
    }
    
    static var _isUnary: Bool {
        logger.traceCall()
        return true
    }
    
    static func _makeLink<A>(in buffer: inout _DynamicViewPropertyBuffer, container: _GraphValue<A>, linkOffset: Int, inputs: inout _ViewInputs) -> () {
        logger.traceCall()
    }
}
class PureBindableObject: BindableObject, Loggable {
    let _didChange = PassthroughSubject<Int, Never>()
    var didChange: PassthroughSubject<Int, Never> {
        logger.traceCall()
        return _didChange
    }
}
class MyBindableObject: BindableObject, _BindableObjectViewProperty, Loggable {
    let _didChange = PassthroughSubject<Int, Never>()
    var didChange: PassthroughSubject<Int, Never> {
        logger.traceCall()
        return _didChange
    }

    func update() {
        logger.traceCall()
    }
    
    static var _isUnary: Bool {
        logger.traceCall()
        return false
    }
    
    static func _makeLink<A>(in buffer: inout _DynamicViewPropertyBuffer, container: _GraphValue<A>, linkOffset: Int, inputs: inout _ViewInputs) -> () {
        logger.traceCall()
    }

    static func _makeLinkForState<V>(in buffer: inout _DynamicViewPropertyBuffer, container: _GraphValue<V>, linkOffset: Int, inputs: inout _ViewInputs) {
        logger.traceCall()
    }
}

class MyUnaryBindableObject: BindableObject, Loggable {
    let didChange = PassthroughSubject<Int, Never>()
    
    func update() {
        logger.traceCall()
    }
    
    static var _isUnary: Bool {
        logger.traceCall()
        return true
    }
    
    static func _makeLink<A>(in: inout _DynamicViewPropertyBuffer, container: _GraphValue<A>, linkOffset: Int, inputs: inout _ViewInputs) -> () {
        logger.traceCall()
    }

    static func _makeLinkForState<V>(in buffer: inout _DynamicViewPropertyBuffer, container: _GraphValue<V>, linkOffset: Int, inputs: inout _ViewInputs) {
        logger.traceCall()
    }
}

func is_BindableObjectViewProperty<T: _BindableObjectViewProperty>(_: T.Type) {}
