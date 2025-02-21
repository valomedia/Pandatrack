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

@resultBuilder struct OrderedSetBuilder<Result> where Result: Hashable {

    // MARK: - Static methods

    static func buildBlock() -> OrderedSet<Result> {
        OrderedSet<Result>()
    }

    static func buildBlock(_ components: Result...) -> OrderedSet<Result> {
        OrderedSet(components)
    }

}
