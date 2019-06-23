//
//  Fields.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/23.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

import SwiftUI
import Combine

struct AnyPropertyType: Identifiable {
    let name: String
    let isUnary: Bool
    let id: ObjectIdentifier
    init<Prop: DynamicViewProperty>(type: Prop.Type) {
        name = _typeName(type, qualified: false)
        id = ObjectIdentifier(type)
        isUnary = type._isUnary
    }
}

struct DVP_Fields_View : View {
    var properties: [AnyPropertyType] = [
        AnyPropertyType(type: State<Int>.self),
        AnyPropertyType(type: ObjectBinding<MyBindableObject>.self),
        AnyPropertyType(type: ObjectBinding<MyUnaryBindableObject>.self),
        AnyPropertyType(type: MyDynamicViewProperty.self),
        AnyPropertyType(type: Binding<Int>.self),
        AnyPropertyType(type: DynamicNavigationDestinationLink<String, String, Text>.self),
        AnyPropertyType(type: Environment<Int>.self),
        AnyPropertyType(type: EnvironmentObject<MyBindableObject>.self),
        AnyPropertyType(type: EnvironmentObject<MyUnaryBindableObject>.self),
        AnyPropertyType(type: GestureState<Int>.self),
    ]
    var body: some View {
        List(properties, rowContent: PropertyTypeSummary.init)
    }
}

extension String: Identifiable {
    public var id: String { self }
}

struct PropertyTypeSummary: View {
    let property: AnyPropertyType
    var rows: [FieldRow] {
        [
            FieldRow(key: "isUnary", value: property.isUnary)
        ]
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(property.name).font(.headline)
            Table(rows: rows) { row -> Text in
                switch row {
                case .key(let key):
                    return Text(key)
                case .value(let value):
                    return Text(value.description)
                }
            }
        }
        .padding()
    }
}

struct FieldRow: TableRow {
    enum Element: Identifiable {
        case key(String), value(CustomStringConvertible)
        var id: String {
            switch self {
            case .key(let s):  return s
            case .value(let s): return s.description
            }
        }
    }
    let elements: [Element]
    let id: String
    init(key: String, value: CustomStringConvertible) {
        elements = [.key(key), .value(value)]
        id = "\(key)_\(value.description)"
    }
}
