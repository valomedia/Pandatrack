//
//  Bool+else.swift
//  Chronos
//

import Foundation


// MARK: Bool

extension Bool {

    // MARK: + else

    func `else`<Value>(_ value: Value) -> Value? {
        self ? nil : value
    }

    func `else`<Value>(_ value: Value?) -> Value? {
        self ? nil : value
    }

}
