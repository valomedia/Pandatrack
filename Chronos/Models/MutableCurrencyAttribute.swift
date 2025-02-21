//
//  MutableCurrencyAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableCurrencyAttribute

@objc(MutableCurrencyAttribute)
class MutableCurrencyAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    convenience init(from immutable: CurrencyAttribute) {
        self.init(immutable.currency, id: immutable.id)
    }

    convenience override init() {
        self.init(from: CurrencyAttribute())
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

    var id: UUID

    var currency: Currency

    var value: Any {
        get {
            currency
        }
        set {
            currency = newValue as! Currency
        }
    }

    override var description: String {
        CurrencyAttribute(from: self).description
    }

    var localizedDescription: String {
        CurrencyAttribute(from: self).localizedDescription
    }

    var accessibilityDescription: String {
        CurrencyAttribute(from: self).accessibilityDescription
    }

}
