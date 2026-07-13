//
//  BuiltinAttribute.swift
//  Chronos
//

import Foundation


// MARK: BuiltinAttribute

protocol BuiltinAttribute: Attribute, NSCopying, NSMutableCopying, NSSecureCoding {

    // MARK: - Properties

    var id: UUID { get }

    var value: Any { get }

}
