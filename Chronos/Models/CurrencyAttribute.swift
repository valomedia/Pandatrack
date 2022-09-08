//
//  CurrencyAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: CurrencyAttribute

/**
 - Todo: Document.
 */
@objc(CurrencyAttribute)
public class CurrencyAttribute: NSObject, BuiltinAttribute {

    // MARK: - Keys

    /**
     - Todo: Document
     */
    enum Keys: String {
        case id
        case currency
    }

    // MARK: - Static properties

    /**
     - Todo: Document
     */
    public static var supportsSecureCoding: Bool = true

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - currency:
       - id:
     */
    public required init(_ currency: Currency, id: UUID = UUID()) {
        self.currency = currency
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter mutable:
     */
    public convenience init(from mutable: MutableCurrencyAttribute) {
        self.init(mutable.currency, id: mutable.id)
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.currency.rawValue) as! Currency,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(currency, forKey: Keys.currency.rawValue)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        Self(currency, id: id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableCurrencyAttribute(from: self)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public let id: UUID

    /**
     - Todo: Document.
     */
    public let currency: Currency

    /**
     - Todo: Document
     */
    public var value: Any {
        currency
    }

    /**
     - Todo: Document
     */
    public override var description: String {
        currency.description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        description
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        localizedDescription
    }
}
