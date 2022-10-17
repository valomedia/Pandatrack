//
//  MutablePercentageAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutablePercentageAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(MutablePercentageAttribute)
public class MutablePercentageAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - percentage:
    ///     - id:
    ///
    public required init(_ percentage: Int, id: UUID) {
        self.percentage = percentage
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - immutable:
    ///
    public convenience init(from immutable: PercentageAttribute) {
        self.init(immutable.percentage, id: immutable.id)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        PercentageAttribute(from: self)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(percentage, id: id)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var percentage: Int

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        get {
            percentage
        }
        set {
            percentage = newValue as! Int
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).accessibilityDescription
    }

}
