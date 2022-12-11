//
//  View+if.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//
//

import Foundation
import SwiftUI


// MARK: View

extension View {

    // MARK: + if

    /// Applies the given transform if the given condition evaluates to true.
    ///
    /// - Parameters:
    ///     - condition: The condition to evaluate
    ///     - transform: The transform to apply to the source View.
    /// - Returns: Either the original View or the modified View.
    ///
    @ViewBuilder
    func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content)
            -> _ConditionalContent<Content, Self> {
        if condition() {
            transform(self)
        } else {
            self
        }
    }

}