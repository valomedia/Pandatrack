//
//  URLAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: URLAttribute

/**
 - Todo: Document.
 */
@objc(URLAttribute)
public class URLAttribute: NSObject, BuiltinAttribute {

    // MARK: - Keys

    /**
     - Todo: Document.
     */
    public enum Keys: String {
        case id
        case url
    }

    // MARK: - Static properties

    /**
     - Todo: Document.
     */
    public static var supportsSecureCoding: Bool = true

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - url:
       - id:
     */
    public required init(_ url: URL, id: UUID = UUID()) {
        self.url = url
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter mutable:
     */
    public convenience init(from mutable: MutableURLAttribute) {
        self.init(mutable.url, id: mutable.id)
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.url.rawValue) as! URL,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(url, forKey: Keys.url.rawValue)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        Self(url, id: id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableURLAttribute(from: self)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public let id: UUID

    /**
     - Todo: Document.
     */
    public let url: URL

    /**
     - Todo: Document.
     */
    public var value: Any {
        url
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        url.description
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
