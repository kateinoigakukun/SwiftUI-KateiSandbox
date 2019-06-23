//
//  Logger.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/23.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

class Logger {
    let typeName: String
    init<Target>(target: Target.Type) {
        typeName = _typeName(Target.self, qualified: false)
    }
    func traceCall(function: StaticString = #function, file: StaticString = #file, line: UInt = #line) {
        print("[\(typeName)] \(function) is called\n  in \(file):\(line)")
    }
}


protocol Loggable {
    var logger: Logger { get }
    static var logger: Logger { get }
}


extension Loggable {
    var logger: Logger { Logger(target: Self.self) }
    static var logger: Logger { Logger(target: Self.self) }
}
