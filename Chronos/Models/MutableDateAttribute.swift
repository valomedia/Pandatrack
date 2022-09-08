//
//  MutableDateAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableDateAttribute

/**
 - Todo: Document.
 */
@objc(MutableDateAttribute)
public class MutableDateAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - date:
       - showTime:
       - id:
     */
    public required init(_ date: Date, showTime: Bool, id: UUID) {
        self.date = date
        self.showTime = showTime
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter immutable:
     */
    public convenience init(from immutable: DateAttribute) {
        self.init(immutable.date, showTime: immutable.showTime, id: immutable.id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        DateAttribute(from: self)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(date, showTime: showTime, id: id)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public var id: UUID

    /**
     - Todo: Document.
     */
    public var date: Date

    /**
     - Todo: Document.
     */
    public var showTime: Bool

    /**
     - Todo: Document.
     */
    public var value: Any {
        get {
            date
        }
        set {
            date = newValue as! Date
        }
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).localizedDescription
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).accessibilityDescription
    }
}
