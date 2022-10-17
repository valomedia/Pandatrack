//
//  MutableURLAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableURLAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(MutableURLAttribute)
public class MutableURLAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - url:
    ///     - id
    ///
    public required init(_ url: URL, id: UUID) {
        self.url = url
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - immutable:
    ///
    public convenience init(from immutable: URLAttribute) {
        self.init(immutable.url, id: immutable.id)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        URLAttribute(from: self)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(url, id: id)
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
    public var url: URL

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        get {
            url
        }
        set {
            url = newValue as! URL
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).accessibilityDescription
    }

}
