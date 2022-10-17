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
public class MutableStringAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - string:
    ///     - id:
    ///
    public required init(_ string: String, id: UUID) {
        self.string = string
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - immutable:
    ///
    public convenience init(from immutable: StringAttribute) {
        self.init(immutable.string, id: immutable.id)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        StringAttribute(from: self)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(string, id: id)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var string: String

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
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
    public override var description: String {
        // TODO Replace this with a more efficient solution.
        StringAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution
        StringAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution
        StringAttribute(from: self).accessibilityDescription
    }

}
