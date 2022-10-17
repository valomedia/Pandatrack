//
//  CurrencyAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: CurrencyAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(CurrencyAttribute)
public class CurrencyAttribute: NSObject, BuiltinAttribute {

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    enum Keys: String {
        case id
        case currency
    }

    // MARK: - Static properties

    public static let supportsSecureCoding = true

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - currency:
    ///     - id:
    ///
    public required init(_ currency: Currency, id: UUID = UUID()) {
        self.currency = currency
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - mutable:
    ///
    public convenience init(from mutable: MutableCurrencyAttribute) {
        self.init(mutable.currency, id: mutable.id)
    }

    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.currency.rawValue) as! Currency,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(currency, forKey: Keys.currency.rawValue)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        Self(currency, id: id)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableCurrencyAttribute(from: self)
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
    public let currency: Currency

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        currency
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        currency.description
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
