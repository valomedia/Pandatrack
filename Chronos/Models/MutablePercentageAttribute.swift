//
//  MutablePercentageAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutablePercentageAttribute

/**
 - Todo: Document.
 */
@objc(MutablePercentageAttribute)
public class MutablePercentageAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     - Parameters:
       - percentage:
       - id:
     */
    public required init(_ percentage: Int, id: UUID) {
        self.percentage = percentage
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter immutable:
     */
    public convenience init(from immutable: PercentageAttribute) {
        self.init(immutable.percentage, id: immutable.id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        PercentageAttribute(from: self)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(percentage, id: id)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public var id: UUID

    /**
     - Todo: Document.
     */
    public var percentage: Int

    /**
     - Todo: Document.
     */
    public var value: Any {
        get {
            percentage
        }
        set {
            percentage = newValue as! Int
        }
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).localizedDescription
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).accessibilityDescription
    }
}
