//
//  Binding+nilCoalescingOperator.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: Binding

extension Binding {

    // MARK: + nilCoalescingOperator

    static func ??<Type>(left: Binding<Value>, right: @escaping @autoclosure () -> Type) -> Binding<Type>
            where Value == Type? {
        Binding<Type>(get: { left.wrappedValue ?? right() }, set: { newValue in left.wrappedValue = newValue })
    }

}
