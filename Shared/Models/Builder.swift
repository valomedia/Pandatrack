//
//  Builder.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation


// MARK: Builder

///
/// - Todo: Document.
@resultBuilder
struct Builder<Result> {

    // MARK: - Static methods

    static func buildBlock() -> [Result] {
        []
    }

    static func buildBlock(_ components: Result...) -> [Result] {
        components
    }
}
