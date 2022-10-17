//
//  SetBuilder.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation


// MARK: SetBuilder

/// Undocumented.
///
/// - Todo: Document.
///
@resultBuilder struct SetBuilder<Result> where Result: Hashable {

    // MARK: - Static methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static func buildBlock() -> Set<Result> {
        Set<Result>()
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static func buildBlock(_ components: Result...) -> Set<Result> {
        Set(components)
    }

}
