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
    var name: String { get set }

    ///
    /// - Todo: Document.
    var path: String { get }

    ///
    /// - Todo: Document.
    var parent: Self? { get set }

    ///
    /// - Todo: Document.
    var children: Set<Self> { get set }

}

// MARK: + path

extension Tree {

    // MARK: - Properties

    // TODO Cache the result of this for the lifetime of the object.
    var path: String {
        [ parent?.path, name ].compactMap({ $0 }).joined(separator: Self.pathSeparator)
    }

}
