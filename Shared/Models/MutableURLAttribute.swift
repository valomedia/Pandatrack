//
//  MutableURLAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableURLAttribute

/**
 - Todo: Document.
 */
@objc(MutableURLAttribute)
public class MutableURLAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - url:
       - id:
     */
    public required init(_ url: URL, id: UUID) {
        self.url = url
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter immutable:
     */
    public convenience init(from immutable: URLAttribute) {
        self.init(immutable.url, id: immutable.id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        URLAttribute(from: self)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(url, id: id)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public var id: UUID

    /**
     - Todo: Document.
     */
    public var url: URL

    /**
     - Todo: Document.
     */
    public var value: Any {
        get {
            url
        }
        set {
            url = newValue as! URL
        }
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).localizedDescription
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).accessibilityDescription
    }
}
