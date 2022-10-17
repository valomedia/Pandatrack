//
//  URLAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: URLAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(URLAttribute)
public class URLAttribute: NSObject, BuiltinAttribute {

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public enum Keys: String {
        case id
        case url
    }

    // MARK: - Static properties

    public static let supportsSecureCoding = true

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - url:
    ///     - id:
    ///
    public required init(_ url: URL, id: UUID = UUID()) {
        self.url = url
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - mutable:
    ///
    public convenience init(from mutable: MutableURLAttribute) {
        self.init(mutable.url, id: mutable.id)
    }

    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.url.rawValue) as! URL,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(url, forKey: Keys.url.rawValue)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        Self(url, id: id)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableURLAttribute(from: self)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let url: URL

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        url
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        url.description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        localizedDescription
    }

}
