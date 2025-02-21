//
//  CurrencyAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: CurrencyAttribute

@objc(CurrencyAttribute)
class CurrencyAttribute: NSObject, BuiltinAttribute {

    enum Keys: String {
        case id
        case currency
    }

    // MARK: - Static properties

    static let supportsSecureCoding = true

    // MARK: - Life cycle methods

    convenience init(from mutable: MutableCurrencyAttribute) {
        self.init(mutable.currency, id: mutable.id)
    }

    convenience override init() {
        self.init(Currency())
    }

    required init(_ currency: Currency, id: UUID = UUID()) {
        self.currency = currency
        self.id = id
    }

    required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.currency.rawValue) as! Currency,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(currency, forKey: Keys.currency.rawValue)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        Self(currency, id: id)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableCurrencyAttribute(from: self)
    }

    // MARK: - Properties

    let id: UUID

    let currency: Currency

    var value: Any {
        currency
    }

    override var description: String {
        currency.description
    }

    var localizedDescription: String {
        description
    }

    var accessibilityDescription: String {
        localizedDescription
    }

}
