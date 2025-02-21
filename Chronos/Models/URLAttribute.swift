//
//  URLAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: URLAttribute

@objc(URLAttribute)
class URLAttribute: NSObject, BuiltinAttribute {

    enum Keys: String {
        case id
        case url
    }

    // MARK: - Static properties

    static let supportsSecureCoding = true

    // MARK: - Life cycle methods

    convenience init(from mutable: MutableURLAttribute) {
        self.init(mutable.url, id: mutable.id)
    }

    convenience override init() {
        self.init(URL(string: ".")!)
    }

    required init(_ url: URL, id: UUID = UUID()) {
        self.url = url
        self.id = id
    }

    required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.url.rawValue) as! URL,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(url, forKey: Keys.url.rawValue)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        Self(url, id: id)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableURLAttribute(from: self)
    }

    // MARK: - Properties

    let id: UUID

    let url: URL

    var value: Any {
        url
    }

    override var description: String {
        url.description
    }

    var localizedDescription: String {
        description
    }

    var accessibilityDescription: String {
        localizedDescription
    }

}
