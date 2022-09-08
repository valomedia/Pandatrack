//
//  Tree.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-08-22.
//
//

import Foundation


// MARK: Tree

///
/// - Todo: Document.
public protocol Tree: Node, Item {

    // MARK: - Static properties

    // MARK: - Class methods

    // MARK: - Life cycle methods

    // MARK: - Properties

    ///
    /// - Todo: Document.
    var children: Set<Self> { get set }

    // MARK: - Methods
}
