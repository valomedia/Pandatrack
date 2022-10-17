//
//  Builder.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation


// MARK: Builder

/// Undocumented.
///
/// - Todo: Document.
///
@resultBuilder struct Builder<Result> {

    // MARK: - Static methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static func buildBlock() -> [Result] {
        []
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static func buildBlock(_ components: Result...) -> [Result] {
        components
    }

}
