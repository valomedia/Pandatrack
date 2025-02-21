//
//  StringAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: StringAttribute

@objc(StringAttribute)
class StringAttribute: NSObject, BuiltinAttribute {

    enum Keys: String {
        case id
        case string
    }

    // MARK: - Static properties

    static var supportsSecureCoding = true

    // MARK: - Life cycle methods

    convenience init(from mutable: MutableStringAttribute) {
        self.init(mutable.string, id: mutable.id)
    }

    convenience override init() {
        self.init("")
    }

    required init(_ string: String, id: UUID = UUID()) {
        self.string = string
        self.id = id
    }

    required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.string.rawValue) as! String,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(string, forKey: Keys.string.rawValue)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        Self(string, id: id)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableStringAttribute(from: self)
    }

    // MARK: Properties

    let id: UUID

    let string: String

    var value: Any {
        string
    }

    override var description: String {
        string.description
    }

    var localizedDescription: String {
        description
    }

    var accessibilityDescription: String {
        localizedDescription
    }

}
