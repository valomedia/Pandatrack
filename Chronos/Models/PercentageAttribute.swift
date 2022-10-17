//
//  PercentageAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: PercentageAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(PercentageAttribute)
public class PercentageAttribute: NSObject, BuiltinAttribute {

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public enum Keys: String {
        case id
        case percentage
    }

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public static var supportsSecureCoding = true

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - percentage:
    ///     - id:
    ///
    public required init(_ percentage: Int, id: UUID = UUID()) {
        self.percentage = percentage
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - mutable:
    ///
    public convenience init(from mutable: MutablePercentageAttribute) {
        self.init(mutable.percentage, id: mutable.id)
    }

    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeInteger(forKey: Keys.percentage.rawValue),
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(percentage, forKey: Keys.percentage.rawValue)
    }

    public func copy(with zone:NSZone? = nil) -> Any {
        Self(percentage, id: id)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutablePercentageAttribute(from: self)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let percentage: Int

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        percentage
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        "\(percentage)%"
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        if #available(macCatalyst 15.0, iOS 15.0, *) {
            return percentage.formatted(.percent)
        } else {
            // Fallback on earlier versions
            return description
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        localizedDescription
    }

}
