//
//  Node.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-12.
//
//

import Foundation


// MARK: Node

protocol Node: Entity, Item, Comparable {

    // MARK: - Static properties

    static var pathSeparator: String { get }

    // MARK: - Properties

    var path: String { get }

    var parent: Self? { get set }

}

extension Node {

    // MARK: + pathSeparator

    static var pathSeparator: String {
        "/"
    }

    // MARK: + path

    /// The path to this Node.
    ///
    var path: String {
        [parent?.path, name].compacted().joined(separator: Self.pathSeparator)
    }

    // MARK: + Comparable

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.path < rhs.path
    }

}

