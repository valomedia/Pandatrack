//
//  NumberAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: NumberAttribute

/**
 - Todo: Document.
 */
@objc(NumberAttribute)
public class NumberAttribute: NSObject, BuiltinAttribute {

    // MARK: - Keys

    /**
     - Todo: Document.
     */
    enum Keys: String {
        case id
        case number
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
       - number:
       - id:
     */
    public required init(_ number: Double, id: UUID = UUID()) {
        self.number = number
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter mutable:
     */
    public convenience init(from mutable: MutableNumberAttribute) {
        self.init(mutable.number, id: mutable.id)
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.number.rawValue) as! Double,
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(number, forKey: Keys.number.rawValue)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        Self(number, id: id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableNumberAttribute(from: self)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public let id: UUID

    /**
     - Todo: Document.
     */
    public let number: Double

    /**
     - Todo: Document.
     */
    public var value: Any {
        number
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        number.description
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        if #available(macCatalyst 15.0, iOS 15.0, *) {
            return number.formatted(.number)
        } else {
            // Fallback on earlier versions
            return description
        }
    }

    /**
     - Todo: Document.
     */
    public var accessibilityDescription: String {
        localizedDescription
    }
}
