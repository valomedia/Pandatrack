//
//  View+ifNotNil.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//
//

import Foundation
import SwiftUI


// MARK: View

// MARK: + ifNotNil

extension View {

    // MARK: - Methods

    /// Applies the given transform if the given optional is not nil.
    ///
    /// - Parameters:
    ///     - optional: An optional.
    ///     - transform: The transform to apply to the source View.
    /// - Returns: Either the original View or the modified View.
    ///
    @ViewBuilder
    func ifNotNil<Content: View, Type: Any>(_ optional: @autoclosure () -> Type?, transform: (Self, Type) -> Content)
            -> some View {
        if let x = optional() {
            transform(self, x)
        } else {
            self
        }
    }
}