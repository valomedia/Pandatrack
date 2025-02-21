//
//  MutableURLAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableURLAttribute

@objc(MutableURLAttribute)
class MutableURLAttribute: NSObject, MutableBuiltinAttribute {

    // MARK: - Life cycle methods

    convenience init(from immutable: URLAttribute) {
        self.init(immutable.url, id: immutable.id)
    }

    convenience override init() {
        self.init(from: URLAttribute())
    }

    required init(_ url: URL, id: UUID) {
        self.url = url
        self.id = id
    }

    func copy(with zone: NSZone? = nil) -> Any {
        URLAttribute(from: self)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        Self(url, id: id)
    }

    // MARK: - Properties

    var id: UUID

    var url: URL

    var value: Any {
        get {
            url
        }
        set {
            url = newValue as! URL
        }
    }

    override var description: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).description
    }

    var localizedDescription: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).localizedDescription
    }

    var accessibilityDescription: String {
        // TODO Replace this with a more efficient solution.
        URLAttribute(from: self).accessibilityDescription
    }

}
