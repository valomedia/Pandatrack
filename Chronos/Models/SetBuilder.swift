//
//  SetBuilder.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation


// MARK: SetBuilder

@resultBuilder struct SetBuilder<Result> where Result: Hashable {

    // MARK: - Static methods

    static func buildBlock() -> Set<Result> {
        Set<Result>()
    }

    static func buildBlock(_ components: Result...) -> Set<Result> {
        Set(components)
    }

}
