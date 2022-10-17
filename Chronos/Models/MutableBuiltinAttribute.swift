//
//  MutableBuiltinAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-25.
//
//

import Foundation


// MARK: MutableBuiltinAttribute

/// Undocumented.
///
/// - Todo: Document.
///
protocol MutableBuiltinAttribute: Attribute, NSCopying, NSMutableCopying {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var id: UUID { get set }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any { get set }

}
