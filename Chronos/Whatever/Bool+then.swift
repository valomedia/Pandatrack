//
//  Bool+then.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-05.
//
//

import Foundation


// MARK: Bool

extension Bool {

    // MARK: + then

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - value:
    /// - Returns:
    ///
    func then<Value>(_ value: Value) -> Value? {
        self ? value : nil
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - value:
    /// - Returns:
    ///
    func then<Value>(_ value: Value?) -> Value? {
        self ? value : nil
    }

}