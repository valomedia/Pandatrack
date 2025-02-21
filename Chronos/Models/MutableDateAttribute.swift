//
//  MutableDateAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-03-26.
//
//

import Foundation


// MARK: MutableDateAttribute

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

    var id: UUID

    var date: Date

    var showTime: Bool

    var value: Any {
        get {
            date
        }
        set {
            date = newValue as! Date
        }
    }

    override var description: String {
        DateAttribute(from: self).description
    }

    var localizedDescription: String {
        DateAttribute(from: self).localizedDescription
    }

    var accessibilityDescription: String {
        DateAttribute(from: self).accessibilityDescription
    }

}
