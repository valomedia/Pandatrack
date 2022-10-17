//
//  NumberAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: NumberAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(NumberAttribute)
public class NumberAttribute: NSObject, BuiltinAttribute {

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    enum Keys: String {
        case id
        case number
    }

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public static let supportsSecureCoding = true

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - number:
    ///     - id:
    ///
    public required init(_ number: Double, id: UUID = UUID()) {
        self.number = number
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - mutable:
    ///
    public convenience init(from mutable: MutableNumberAttribute) {
        self.init(mutable.number, id: mutable.id)
    }

    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.number.rawValue) as! Double,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(number, forKey: Keys.number.rawValue)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        Self(number, id: id)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableNumberAttribute(from: self)
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
    public let number: Double

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        number
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        number.description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        if #available(macCatalyst 15.0, iOS 15.0, *) {
            return number.formatted(.number)
        } else {
            // Fallback on earlier versions
            return description
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        localizedDescription
    }

}
