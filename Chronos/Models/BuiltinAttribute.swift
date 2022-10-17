//
//  BuiltinAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: BuiltinAttribute

/// Undocumented.
///
/// - Todo: Document.
///
protocol BuiltinAttribute: Attribute, NSCopying, NSMutableCopying, NSSecureCoding {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var id: UUID { get }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any { get }

}
