//
//  StringAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: StringAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(StringAttribute)
class StringAttribute: NSObject, BuiltinAttribute {

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    enum Keys: String {
        case id
        case string
    }

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
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

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let string: String

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any {
        string
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    override var description: String {
        string.description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var localizedDescription: String {
        description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var accessibilityDescription: String {
        localizedDescription
    }

}
