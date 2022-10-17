//
//  MutableCurrencyAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableCurrencyAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(MutableCurrencyAttribute)
public class MutableCurrencyAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - currency
    ///     - id
    ///
    public required init(_ currency: Currency, id: UUID) {
        self.currency = currency
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - immutable:
    ///
    public convenience init(from immutable: CurrencyAttribute) {
        self.init(immutable.currency, id: immutable.id)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        CurrencyAttribute(from: self)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(currency, id: id)
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
    public var currency: Currency

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        get {
            currency
        }
        set {
            currency = newValue as! Currency
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).accessibilityDescription
    }

}
