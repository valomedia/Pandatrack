//
//  Entry+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: Entry

/// Undocumented.
///
/// - Todo: Document.
///
@objc(Entry)
class Entry: NSManagedObject, Item {

    // MARK: - Static properties

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        guard !entity.isAbstract else { fatalError("init(entity:insertInto:) has not been implemented") }
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Properties

    ////// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var interval: DateInterval {
        DateInterval(start: start, end: Date())
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var duration: TimeInterval {
        get { interval.duration }
        set { start = Date() - newValue }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var theme: Theme {
        project?.resolveTheme() ?? Theme.none
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @objc public var day: String {
        Self.dateFormatter.string(from: start)
    }

}
