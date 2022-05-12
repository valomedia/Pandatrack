//
//  Tree.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-12.
//
//

import Foundation


// MARK: Tree

///
/// - Todo: Document.
protocol Tree: Hashable {

    // MARK: - Static properties

    ///
    /// - Todo: Document.
    static var pathSeparator: String { get }

    // MARK: - Properties

    ///
    /// - Todo: Document.
    var parent: Self? { get set }

    ///
    /// - Todo: Document.
    var children: Set<Self> { get set }
}
