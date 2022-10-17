//
//  MutableNumberAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableNumberAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(MutableNumberAttribute)
public class MutableNumberAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - number:
    ///     - id:
    ///
    public required init(_ number: Double, id: UUID) {
        self.number = number
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - immutable:
    ///
    public convenience init(from immutable: NumberAttribute) {
        self.init(immutable.number, id: immutable.id)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        NumberAttribute(from: self)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(number, id: id)
    }

    // MARK: Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var number: Double

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        get {
            number
        }
        set {
            number = newValue as! Double
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).accessibilityDescription
    }

}
