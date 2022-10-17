//
//  OrderedSetBuilder.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import OrderedCollections


// MARK: OrderedSetBuilder

/// Undocumented.
///
/// - Todo: Document.
///
@resultBuilder struct OrderedSetBuilder<Result> where Result: Hashable {

    // MARK: - Static methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static func buildBlock() -> OrderedSet<Result> {
        OrderedSet<Result>()
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static func buildBlock(_ components: Result...) -> OrderedSet<Result> {
        OrderedSet(components)
    }

}
