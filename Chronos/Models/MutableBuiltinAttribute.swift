//
//  MutableBuiltinAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-25.
//
//

import Foundation


// MARK: MutableBuiltinAttribute

protocol MutableBuiltinAttribute: Attribute, NSCopying, NSMutableCopying {

    // MARK: - Properties

    var id: UUID { get set }

    var value: Any { get set }

}
