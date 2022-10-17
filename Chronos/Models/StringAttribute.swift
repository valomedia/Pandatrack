//
//  StringAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: StringAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(StringAttribute)
public class StringAttribute: NSObject, BuiltinAttribute {

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public enum Keys: String {
        case id
        case string
    }

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public static var supportsSecureCoding = true

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - string:
    ///     - id:
    ///
    public required init(_ string: String, id: UUID = UUID()) {
        self.string = string
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - mutable:
    ///
    public convenience init(from mutable: MutableStringAttribute) {
        self.init(mutable.string, id: mutable.id)
    }

    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.string.rawValue) as! String,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(string, forKey: Keys.string.rawValue)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        Self(string, id: id)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableStringAttribute(from: self)
    }

    // MARK: Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let string: String

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        string
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        string.description
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
