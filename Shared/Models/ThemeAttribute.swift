//
//  ThemeAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: ThemeAttribute

/**
 - Todo: Document.
 */
@objc(ThemeAttribute)
public class ThemeAttribute: NSObject, BuiltinAttribute {

    // MARK: - Keys

    /**
     - Todo: Document.
     */
    public enum Keys: String {
        case id
        case theme
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
       - theme:
       - id:
     */
    public required init(_ theme: Theme, id: UUID = UUID()) {
        self.theme = theme
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter mutable:
     */
    public convenience init(from mutable: MutableThemeAttribute) {
        self.init(mutable.theme, id: mutable.id)
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.theme.rawValue) as! Theme,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(theme, forKey: Keys.theme.rawValue)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        Self(theme, id: id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableThemeAttribute(from: self)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public let id: UUID

    /**
     - Todo: Document.
     */
    public let theme: Theme

    /**
     - Todo: Document.
     */
    public var value: Any {
        theme
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        theme.description
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
