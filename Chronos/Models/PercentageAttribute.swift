//
//  PercentageAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: PercentageAttribute

@objc(PercentageAttribute)
class PercentageAttribute: NSObject, BuiltinAttribute {

    enum Keys: String {
        case id
        case percentage
    }

    // MARK: - Static properties

    static var supportsSecureCoding = true

    // MARK: - Life cycle methods

    convenience init(from mutable: MutablePercentageAttribute) {
        self.init(mutable.percentage, id: mutable.id)
    }

    convenience override init() {
        self.init(0)
    }

    required init(_ percentage: Int, id: UUID = UUID()) {
        self.percentage = percentage
        self.id = id
    }

    required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeInteger(forKey: Keys.percentage.rawValue),
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(percentage, forKey: Keys.percentage.rawValue)
    }

    func copy(with zone:NSZone? = nil) -> Any {
        Self(percentage, id: id)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutablePercentageAttribute(from: self)
    }

    // MARK: - Properties

    let id: UUID

    let percentage: Int

    var value: Any {
        percentage
    }

    override var description: String {
        "\(percentage)%"
    }

    var localizedDescription: String {
        if #available(macCatalyst 15.0, iOS 15.0, *) {
            return percentage.formatted(.percent)
        } else {
            // Fallback on earlier versions
            return description
        }
    }

    var accessibilityDescription: String {
        localizedDescription
    }

}
