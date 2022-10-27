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
class MutableCurrencyAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - immutable:
    ///
    convenience init(from immutable: CurrencyAttribute) {
        self.init(immutable.currency, id: immutable.id)
    }

    required init(_ currency: Currency, id: UUID) {
        self.currency = currency
        self.id = id
    }

    func copy(with zone: NSZone? = nil) -> Any {
        CurrencyAttribute(from: self)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(currency, id: id)
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
    var currency: Currency

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any {
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
    override var description: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var localizedDescription: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution
        CurrencyAttribute(from: self).accessibilityDescription
    }

}
