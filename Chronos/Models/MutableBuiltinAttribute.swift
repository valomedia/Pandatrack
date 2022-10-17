//
//  MutableBuiltinAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-25.
//
//

import Foundation


// MARK: MutableBuiltinAttribute

/**
 - Todo: Document.
 */
public protocol MutableBuiltinAttribute: Attribute, NSCopying, NSMutableCopying {

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    var id: UUID { get set }

    /**
     - Todo: Document.
     */
    var value: Any { get set }
}
