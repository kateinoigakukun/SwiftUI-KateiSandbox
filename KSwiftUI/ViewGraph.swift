//
//  ViewGraph.swift
//  KSwiftUI
//
//  Created by kateinoigakukun on 2019/06/24.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

struct _DynamicViewPropertyBuffer {
}

protocol DynamicViewProperty {
    static func _makeLink<V>(in buffer: inout _DynamicViewPropertyBuffer, container: _GraphValue<V>, linkOffset: Int, inputs: inout _ViewInputs)
    mutating func update()
    static var _isUnary: Bool { get }
}

@propertyDelegate
struct State<Value> {
    init(initialValue: Value) {
        self.initialValue = initialValue
    }
    let initialValue: Value
    var value: Value {
        set {
            _location?.value = newValue
        }
        get {
            guard let location = _location else {
                fatalError("State is referenced from not body")
            }
            return location.value
        }
    }
    
    var _location: StoredLocation<Value>?
}

class StoredLocation<Value> {
    var value: Value
    
    init(value: Value) {
        self.value = value
    }
}

class ViewGraph {
    let rootView: AnyView
    init<V: View>(rootView: V) {
        self.rootView = AnyView()
    }
}

struct _GraphValue<Value> : Equatable {
    subscript<U>(keyPath: KeyPath<Value, U>) -> _GraphValue<U> {
        fatalError()
    }
}

struct _ViewOutputs {
}

struct _ViewInputs {
}

protocol View {
    associatedtype Body: View

    var body: Body { get }
    
    static func _makeView(view: _GraphValue<Self>, inputs: _ViewInputs) -> _ViewOutputs
}

extension View {
    static func _makeView(view: _GraphValue<Self>, inputs: _ViewInputs) -> _ViewOutputs {
        fatalError()
    }
}

struct AnyView: View {
    typealias Body = Never
    var body: Never { fatalError() }
}

extension Never: View {
    typealias Body = Never
    var body: Never {
        fatalError()
    }
}

class HostingView<Content: View> {
    init(content: Content) {
        
    }
}
