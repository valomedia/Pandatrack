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

// MARK: + nilCoalescingOperator

/// Undocumented.
///
/// - Todo: Document.
/// - Parameters:
///     - left:
///     - right:
/// - Returns:
///
func ??<Value>(left: Binding<Optional<Value>>, right: @escaping @autoclosure () -> Value) -> Binding<Value> {
    Binding(
            get: {
                left.wrappedValue ?? right()
            },
            set: { newValue in
                left.wrappedValue = newValue
            })
}
