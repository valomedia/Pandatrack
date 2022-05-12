//
//  MutableCurrencyAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableCurrencyAttribute

/**
 - Todo: Document.
 */
@objc(MutableCurrencyAttribute)
public class MutableCurrencyAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - currency:
       - id:
     */
    public required init(_ currency: Currency, id: UUID) {
        self.currency = currency
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter immutable:
     */
    public convenience init(from immutable: CurrencyAttribute) {
        self.init(immutable.currency, id: immutable.id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        CurrencyAttribute(from: self)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(currency, id: id)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public var id: UUID

    /**
     - Todo: Document.
     */
    public var currency: Currency

    /**
     - Todo: Document.
     */
    public var value: Any {
        get {
            currency
        }
        set {
            currency = newValue as! Currency
        }
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).localizedDescription
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).accessibilityDescription
    }
}
