//
//  MutableStringAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-25.
//
//

import Foundation


// MARK: MutableStringAttribute

@objc(MutableStringAttribute)
class MutableStringAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    convenience init(from immutable: StringAttribute) {
        self.init(immutable.string, id: immutable.id)
    }

    convenience override init() {
        self.init(from: StringAttribute())
    }

    required init(_ string: String, id: UUID) {
        self.string = string
        self.id = id
    }

    func copy(with zone: NSZone? = nil) -> Any {
        StringAttribute(from: self)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(string, id: id)
    }

    // MARK: - Properties

    var id: UUID

    var string: String

    var value: Any {
        get {
            string
        }
        set {
            string = newValue as! String
        }
    }

    override var description: String {
        StringAttribute(from: self).description
    }

    var localizedDescription: String {
        StringAttribute(from: self).localizedDescription
    }

    var accessibilityDescription: String {
        StringAttribute(from: self).accessibilityDescription
    }

}
