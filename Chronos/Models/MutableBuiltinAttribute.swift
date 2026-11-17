//
//  MutableBuiltinAttribute.swift
//  Chronos
//

import Foundation


// MARK: MutableBuiltinAttribute

protocol MutableBuiltinAttribute: Attribute, NSCopying, NSMutableCopying {

    // MARK: - Properties

    var id: UUID { get set }

    var value: Any { get set }

}
