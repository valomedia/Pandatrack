//
//  Node.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-12.
//
//

import Foundation


// MARK: Node

/// Undocumented.
///
/// - Todo: Document.
///
public protocol Node: Hashable {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var pathSeparator: String { get }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var name: String { get set }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var path: String { get }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var parent: Self? { get set }

}


extension Node {

    // MARK: + pathSeparator

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public static var pathSeparator: String {
        "/"
    }

    // MARK: + path

    /// The path to this Node.
    ///
    /// - Todo: Cache the result of this for the lifetime of the object.
    ///
    public var path: String {
        [ parent?.path, Self.pathSeparator, name ].compactMap({ $0 }).joined()
    }
}

