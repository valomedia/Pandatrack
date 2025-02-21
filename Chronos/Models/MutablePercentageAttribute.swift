//
//  MutablePercentageAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutablePercentageAttribute

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

    var id: UUID

    var percentage: Int

    var value: Any {
        get {
            percentage
        }
        set {
            percentage = newValue as! Int
        }
    }

    override var description: String {
        PercentageAttribute(from: self).description
    }

    var localizedDescription: String {
        PercentageAttribute(from: self).localizedDescription
    }

    var accessibilityDescription: String {
        PercentageAttribute(from: self).accessibilityDescription
    }

}
