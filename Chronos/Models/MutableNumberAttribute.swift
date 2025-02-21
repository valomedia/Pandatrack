//
//  MutableNumberAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableNumberAttribute

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

    var id: UUID

    var number: Double

    var value: Any {
        get {
            number
        }
        set {
            number = newValue as! Double
        }
    }

    override var description: String {
        NumberAttribute(from: self).description
    }

    var localizedDescription: String {
        NumberAttribute(from: self).localizedDescription
    }

    var accessibilityDescription: String {
        NumberAttribute(from: self).accessibilityDescription
    }

}
