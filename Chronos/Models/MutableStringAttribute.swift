//
//  MutableStringAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-25.
//
//

import Foundation


// MARK: MutableStringAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(MutableStringAttribute)
class MutableStringAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - immutable:
    ///
    convenience init(from immutable: StringAttribute) {
        self.init(immutable.string, id: immutable.id)
    }

    required init(_ string: String, id: UUID) {
        self.string = string
        self.id = id
    }

    func copy(with zone: NSZone? = nil) -> Any {
        StringAttribute(from: self)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(string, id: id)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var string: String

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any {
        get {
            string
        }
        set {
            string = newValue as! String
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    override var description: String {
        // TODO Replace this with a more efficient solution.
        StringAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var localizedDescription: String {
        // TODO Replace this with a more efficient solution
        StringAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution
        StringAttribute(from: self).accessibilityDescription
    }

}
