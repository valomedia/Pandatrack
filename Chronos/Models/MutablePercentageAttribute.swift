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
class MutablePercentageAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    convenience init(from immutable: PercentageAttribute) {
        self.init(immutable.percentage, id: immutable.id)
    }

    convenience override init() {
        self.init(from: PercentageAttribute())
    }

    required init(_ percentage: Int, id: UUID) {
        self.percentage = percentage
        self.id = id
    }

    func copy(with zone: NSZone? = nil) -> Any {
        PercentageAttribute(from: self)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(percentage, id: id)
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
    var percentage: Int

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any {
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
    override var description: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).localizedDescription
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        PercentageAttribute(from: self).accessibilityDescription
    }

}
