//
//  Node.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-12.
//
//

import Foundation


// MARK: Node

///
/// - Todo: Document.
public protocol Node: Hashable {

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

}

// MARK: + pathSeparator

extension Node {

    // MARK: - Static properties

    public static var pathSeparator: String {
        "/"
    }

}

// MARK: + path

extension Node {

    // MARK: - Properties

    // TODO Cache the result of this for the lifetime of the object.
    public var path: String {
        [ parent?.path, name ].compactMap({ $0 }).joined(separator: Self.pathSeparator)
    }

}
