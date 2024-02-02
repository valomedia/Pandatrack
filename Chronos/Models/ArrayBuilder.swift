//
//  ArrayBuilder.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-01-18.
//
//

import Foundation


// MARK: SetBuilder

/// Undocumented.
///
/// - Todo: Document.
///
@resultBuilder struct ArrayBuilder<Result> where Result: Hashable {

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
