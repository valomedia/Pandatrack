//
//  DateAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: DateAttribute

@objc(DateAttribute)
class DateAttribute: NSObject, BuiltinAttribute {

    enum Keys: String {
        case id
        case date
        case showTime
    }

    // MARK: - Static properties

    static let supportsSecureCoding = true

    // MARK: - Life cycle methods

    convenience init(from mutable: MutableDateAttribute) {
        self.init(mutable.date, id: mutable.id)
    }

    convenience override init() {
        self.init(Date())
    }

    required init(_ date: Date, showTime: Bool = false, id: UUID = UUID()) {
        self.date = date
        self.showTime = showTime
        self.id = id

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = showTime ? .short : .none
        self.formatter = formatter

        let accessibilityFormatter = DateFormatter()
        accessibilityFormatter.dateStyle = .long
        accessibilityFormatter.timeStyle = showTime ? .long : .none
        self.accessibilityFormatter = accessibilityFormatter
    }

    required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.date.rawValue) as! Date,
                showTime: coder.decodeBool(forKey: Keys.showTime.rawValue),
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(date, forKey: Keys.date.rawValue)
        coder.encode(showTime, forKey: Keys.showTime.rawValue)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        Self(date, showTime: showTime, id: id)
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableDateAttribute(from: self)
    }

    // MARK: Properties

    let id: UUID

    let date: Date

    let showTime: Bool

    var value: Any {
        date
    }

    override var description: String {
        date.description
    }

    var localizedDescription: String {
        formatter.string(from: date)
    }

    var accessibilityDescription: String {
        accessibilityFormatter.string(from: date)
    }

    private let formatter: DateFormatter
    private let accessibilityFormatter: DateFormatter

}
