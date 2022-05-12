//
//  MutableThemeAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableThemeAttribute

/**
 - Todo: Document.
 */
@objc(MutableThemeAttribute)
public class MutableThemeAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - theme:
       - id:
     */
    public required init(_ theme: Theme, id: UUID) {
        self.theme = theme
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter immutable:
     */
    public convenience init(from immutable: ThemeAttribute) {
        self.init(immutable.theme, id: immutable.id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        ThemeAttribute(from: self)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(theme, id: id)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public var id: UUID

    /**
     - Todo: Document.
     */
    public var theme: Theme

    /**
     - Todo: Document.
     */
    public var value: Any {
        get {
            theme
        }
        set {
            theme = newValue as! Theme
        }
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        // TODO Replace this with a more efficient solution.
        ThemeAttribute(from: self).description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        ThemeAttribute(from: self).localizedDescription
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        ThemeAttribute(from: self).accessibilityDescription
    }
}
