//
//  ManagedTree.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-12.
//
//

import Foundation


// MARK: ManagedTree

///
/// - Todo: Document.
protocol ManagedTree: Tree {

    // MARK: - Properties

    ///
    /// - Todo: Document.
    var name: String { get set }

    ///
    /// - Todo: Document.
    var path: String { get set }

    // MARK: - Methods

    ///
    /// - Todo: Document.
    func awakeFromInsert()

    ///
    /// - Todo: Document.
    func awakeFromFetch()
}

// MARK: + awakeFromInsert()

extension ManagedTree {

    // MARK: - Methods

    mutating func awakeFromInsert() {
        awakeFromFetch()
    }
}

// MARK: + awakeFromFetch()

extension ManagedTree {

    // MARK: - Methods

    mutating func awakeFromFetch() {
        path = [ parent?.path, name ].compactMap({ $0 }).joined(separator: Self.pathSeparator)
    }
}