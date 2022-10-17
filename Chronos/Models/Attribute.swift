//
//  Attribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-13.
//
//

import Foundation


// MARK: Attribute

/**
 - Todo: Document.
 */
public protocol Attribute {

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    var description: String { get }

    /**
     - Todo: Document.
     */
    var localizedDescription: String { get }

    /**
     - Todo: Document.
     */
    var accessibilityDescription: String { get }
}
