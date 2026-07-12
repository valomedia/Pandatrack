//
//  ArrayBuilder.swift
//  Chronos
//

import Foundation


// MARK: SetBuilder

@resultBuilder struct ArrayBuilder<Result> where Result: Hashable {

    // MARK: - Static methods

    static func buildBlock() -> [Result] {
        []
    }

    static func buildBlock(_ components: Result...) -> [Result] {
        components
    }

}
