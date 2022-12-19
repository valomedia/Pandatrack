//
//  DateAttribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: DateAttribute

/// Undocumented.
///
/// - Todo: Document.
///
@objc(DateAttribute)
class DateAttribute: NSObject, BuiltinAttribute {

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    enum Keys: String {
        case id
        case date
        case showTime
    }

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
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

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let date: Date

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let showTime: Bool

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var value: Any {
        date
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    override var description: String {
        date.description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var localizedDescription: String {
        formatter.string(from: date)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var accessibilityDescription: String {
        accessibilityFormatter.string(from: date)
    }

    private let formatter: DateFormatter
    private let accessibilityFormatter: DateFormatter

}
