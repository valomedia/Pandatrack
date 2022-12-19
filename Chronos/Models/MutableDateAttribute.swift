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
class MutableDateAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    convenience init(from immutable: DateAttribute) {
        self.init(immutable.date, showTime: immutable.showTime, id: immutable.id)
    }

    convenience override init() {
        self.init(from: DateAttribute())
    }

    required init(_ date: Date, showTime: Bool, id: UUID) {
        self.date = date
        self.showTime = showTime
        self.id = id
    }

    func copy(with zone: NSZone? = nil) -> Any {
        DateAttribute(from: self)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(date, showTime: showTime, id: id)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var date: Date

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var showTime: Bool

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any {
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
    override var description: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var localizedDescription: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution
        DateAttribute(from: self).accessibilityDescription
    }

}
