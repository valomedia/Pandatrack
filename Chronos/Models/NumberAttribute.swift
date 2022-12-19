//
//  NumberAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: NumberAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(NumberAttribute)
class NumberAttribute: NSObject, BuiltinAttribute {

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    enum Keys: String {
        case id
        case number
    }

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static let supportsSecureCoding = true

    // MARK: - Life cycle methods

    convenience init(from mutable: MutableNumberAttribute) {
        self.init(mutable.number, id: mutable.id)
    }

    convenience override init() {
        self.init(0)
    }

    required init(_ number: Double, id: UUID = UUID()) {
        self.number = number
        self.id = id
    }

    required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.number.rawValue) as! Double,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(number, forKey: Keys.number.rawValue)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        Self(number, id: id)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableNumberAttribute(from: self)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let number: Double

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any {
        number
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    override var description: String {
        number.description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var localizedDescription: String {
        if #available(macCatalyst 15.0, iOS 15.0, *) {
            return number.formatted(.number)
        } else {
            // Fallback on earlier versions
            return description
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var accessibilityDescription: String {
        localizedDescription
    }

}
