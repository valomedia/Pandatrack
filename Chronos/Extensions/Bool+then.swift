//
//  Bool+then.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-05.
//
//

import Foundation

infix operator .!!


// MARK: Bool

extension Bool {

    // MARK: + then

    func then<Value>(_ value: Value) -> Value? {
        self ? value : nil
    }

    func then<Value>(_ value: Value?) -> Value? {
        self ? value : nil
    }

}

func .!!<Value>(left: Bool, right: Value) -> Value? {
    left.then(right)
}

func .!!<Value>(left: Bool, right: Value?) -> Value? {
    left.then(right)
}
