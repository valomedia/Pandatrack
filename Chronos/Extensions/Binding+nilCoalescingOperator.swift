//
//  Binding+nilCoalescingOperator.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-13.
//
//

import Foundation
import SwiftUI


// MARK: Binding

extension Binding {

    // MARK: + nilCoalescingOperator

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - left:
    ///     - right:
    /// - Returns:
    ///
    static func ??<Wrapped>(left: Binding<Value>, right: @escaping @autoclosure () -> Value) -> Binding<Value>
            where Value == Optional<Wrapped> {
        Binding(
                get: {
                    left.wrappedValue ?? right()
                },
                set: { newValue in
                    left.wrappedValue = newValue
                })
    }

}
