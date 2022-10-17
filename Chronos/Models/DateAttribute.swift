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
public class DateAttribute: NSObject, BuiltinAttribute {

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
    public static let supportsSecureCoding = true

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - date:
    ///     - showTime:
    ///     - id:
    ///
    public required init(_ date: Date, showTime: Bool = false, id: UUID = UUID()) {
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

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - mutable:
    ///
    public convenience init(from mutable: MutableDateAttribute) {
        self.init(mutable.date, id: mutable.id)
    }

    public required convenience init?(coder: NSCoder) {
        self.init(
                coder.decodeObject(forKey: Keys.date.rawValue) as! Date,
                showTime: coder.decodeBool(forKey: Keys.showTime.rawValue),
                id: coder.decodeObject(forKey: Keys.id.rawValue) as! UUID
        )
    }

    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(date, forKey: Keys.date.rawValue)
        coder.encode(showTime, forKey: Keys.showTime.rawValue)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        Self(date, showTime: showTime, id: id)
    }

    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        MutableDateAttribute(from: self)
    }

    // MARK: Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let id: UUID

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let date: Date

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public let showTime: Bool

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var value: Any {
        date
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var description: String {
        date.description
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var localizedDescription: String {
        formatter.string(from: date)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var accessibilityDescription: String {
        accessibilityFormatter.string(from: date)
    }

    private let formatter: DateFormatter
    private let accessibilityFormatter: DateFormatter

}
