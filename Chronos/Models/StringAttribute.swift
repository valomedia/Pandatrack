//
//  StringAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: StringAttribute

/**
 - Todo: Document.
 */
@objc(StringAttribute)
public class StringAttribute: NSObject, BuiltinAttribute {

    // MARK: Keys

    /**
     - Todo: Document.
     */
    public enum Keys: String {
        case id
        case string
    }

    // MARK: Static properties

    /**
     - Todo: Document.
     */
    public static var supportsSecureCoding: Bool = true

    // MARK: Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - string:
       - id:
     */
    public required init(_ string: String, id: UUID = UUID()) {
        self.string = string
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter mutable:
     */
    public convenience init(from mutable: MutableStringAttribute) {
        self.init(mutable.string, id: mutable.id)
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.string.rawValue) as! String,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(string, forKey: Keys.string.rawValue)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        Self(string, id: id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableStringAttribute(from: self)
    }

    // MARK: Properties

    /**
     - Todo: Document.
     */
    public let id: UUID

    /**
     - Todo: Document.
     */
    public let string: String

    /**
     - Todo: Document.
     */
    public var value: Any {
        string
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        string.description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        description
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        localizedDescription
    }
}
