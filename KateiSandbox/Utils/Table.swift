//
//  Table.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/23.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

import SwiftUI

protocol TableRow: Identifiable {
    associatedtype Element: Identifiable
    var elements: [Element] { get }
}

struct Table<Row: Identifiable>: View where Row.IdentifiedValue: TableRow {
    let rows: [Row]
    
    let elementView: (Row.IdentifiedValue.Element.IdentifiedValue) -> AnyView
    
    init<Content: View>(rows: [Row], _ elementView: @escaping (Row.IdentifiedValue.Element.IdentifiedValue) -> Content) {
        self.rows = rows
        self.elementView = { AnyView(elementView($0)) }
    }
    
    var body: some View {
        VStack {
            Divider()
            ForEach(rows) { (row) in
                HStack {
                    Divider().frame(maxHeight: 50)
                    ForEach(row.elements) { element in
                        self.elementView(element)
                        Spacer()
                        Divider().frame(maxHeight: 50)
                    }
                }
                Divider()
            }
        }
    }
}

