//
//  BuiltinAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: BuiltinAttribute

/**
 - Todo: Document.
 */
public protocol BuiltinAttribute: Attribute, NSCopying, NSMutableCopying, NSSecureCoding {

    // MARK: Properties

    /**
     - Todo: Document.
     */
    var id: UUID { get }

    /**
     - Todo: Document.
     */
    var value: Any { get }
}
