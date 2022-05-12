//
//  PercentageAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: PercentageAttribute

/**
 - Todo: Document.
 */
@objc(PercentageAttribute)
public class PercentageAttribute: NSObject, BuiltinAttribute {

    // MARK: - Keys

    /**
     - Todo: Document.
     */
    public enum Keys: String {
        case id
        case percentage
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
       - percentage:
       - id:
     */
    public required init(_ percentage: Int, id: UUID = UUID()) {
        self.percentage = percentage
        self.id = id
    }

    /**
     - Todo: Document.
     - Parameter mutable:
     */
    public convenience init(from mutable: MutablePercentageAttribute) {
        self.init(mutable.percentage, id: mutable.id)
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeInteger(forKey: Keys.percentage.rawValue),
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    /**
     - Todo: Document.
     - Parameter coder:
     */
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(percentage, forKey: Keys.percentage.rawValue)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func copy(with zone:NSZone? = nil) -> Any {
        Self(percentage, id: id)
    }

    /**
     - Todo: Document.
     - Parameter zone:
     - Returns:
     */
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutablePercentageAttribute(from: self)
    }

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    public let id: UUID

    /**
     - Todo: Document.
     */
    public let percentage: Int

    /**
     - Todo: Document.
     */
    public var value: Any {
        percentage
    }

    /**
     - Todo: Document.
     */
    public override var description: String {
        "\(percentage)%"
    }

    /**
     - Todo: Document.
     */
    public var localizedDescription: String {
        if #available(macCatalyst 15.0, iOS 15.0, *) {
            return percentage.formatted(.percent)
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
