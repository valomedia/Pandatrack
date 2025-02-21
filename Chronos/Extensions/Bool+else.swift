//
//  Bool+else.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-26.
//
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
