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
class MutableNumberAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: Life cycle methods

    convenience init(from immutable: NumberAttribute) {
        self.init(immutable.number, id: immutable.id)
    }

    convenience override init() {
        self.init(from: NumberAttribute())
    }

    required init(_ number: Double, id: UUID) {
        self.number = number
        self.id = id
    }

    func copy(with zone: NSZone? = nil) -> Any {
        NumberAttribute(from: self)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(number, id: id)
    }

    // MARK: Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var number: Double

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any {
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
    override var description: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        NumberAttribute(from: self).accessibilityDescription
    }

}
