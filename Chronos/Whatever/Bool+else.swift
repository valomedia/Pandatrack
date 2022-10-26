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

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - value:
    /// - Returns:
    ///
    func `else`<Value>(_ value: Value) -> Value? {
        self ? nil : value
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - value:
    /// - Returns:
    ///
    func `else`<Value>(_ value: Value?) -> Value? {
        self ? nil : value
    }

}