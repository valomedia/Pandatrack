//
//  Builder.swift
//  Chronos
//

import Foundation


// MARK: Builder

@resultBuilder struct Builder<Result> {

    // MARK: - Static methods

    static func buildBlock() -> [Result] {
        []
    }

    static func buildBlock(_ components: Result...) -> [Result] {
        components
    }

}
