//
//  MutableNumberAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableNumberAttribute

/**
 - Todo: Document.
 */
@objc(MutableNumberAttribute)
public class MutableNumberAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - number:
       - id:
     */
    public required init(_ number: Double, id: UUID) {
        self.number = number
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter immutable:
     */
    public convenience init(from immutable: NumberAttribute) {
        self.init(immutable.number, id: immutable.id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        NumberAttribute(from: self)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(number, id: id)
    }

    // MARK: Properties

    /**
     - Todo: Document.
     */
    public var id: UUID

    /**
     - Todo: Document.
     */
    public var number: Double

    /**
     - Todo: Document.
     */
    public var value: Any {
        get {
            number
        }
        set {
            number = newValue as! Double
        }
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).localizedDescription
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).accessibilityDescription
    }
}
