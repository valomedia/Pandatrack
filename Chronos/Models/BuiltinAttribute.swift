//
//  BuiltinAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: BuiltinAttribute

protocol BuiltinAttribute: Attribute, NSCopying, NSMutableCopying, NSSecureCoding {

    // MARK: - Properties

    var id: UUID { get }

    var value: Any { get }

}
