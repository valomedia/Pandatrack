//
//  MutableDateAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableDateAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(MutableDateAttribute)
public class MutableDateAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - date:
    ///     - showTime:
    ///     - id:
    ///
    public required init(_ date: Date, showTime: Bool, id: UUID) {
        self.date = date
        self.showTime = showTime
        self.id = id
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - immutable:
    ///
    public convenience init(from immutable: DateAttribute) {
        self.init(immutable.date, showTime: immutable.showTime, id: immutable.id)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        DateAttribute(from: self)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(date, showTime: showTime, id: id)
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
    public var date: Date

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var showTime: Bool

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        get {
            date
        }
        set {
            date = newValue as! Date
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).accessibilityDescription
    }

}
