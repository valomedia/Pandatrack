//
//  CompletedEntry+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: CompletedEntry

/// Undocumented.
///
/// - Todo: Document.
///
@objc(CompletedEntry)
class CompletedEntry: Entry {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static let defaultDuration: TimeInterval = Double(Settings.entryDurationPreference * 60)

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///     - name:
    ///     - start:
    ///     - end:
    ///     - project:
    ///     - tags:
    ///
    convenience init(
            _ context: NSManagedObjectContext,
            name: String? = nil,
            start: Date? = nil,
            end: Date? = nil,
            project: Project? = nil,
            tags: Set<Tag>? = nil
    ) {
        self.init(entity: Self.entity(in: context)!, insertInto: context)
        primitiveName = name ?? ""
        primitiveStart = start ?? Date() - CompletedEntry.defaultDuration
        primitiveEnd = end ?? Date()

        if let project = project { self.project = project }
        if let tags = tags { self.tags = tags }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///     - name:
    ///     - interval:
    ///     - project:
    ///     - tags:
    ///
    convenience init(
            _ context: NSManagedObjectContext,
            name: String? = nil,
            interval: DateInterval,
            project: Project? = nil,
            tags: Set<Tag>? = nil
    ) {
        self.init(context, name: name, start: interval.start, end: interval.end, project: project, tags: tags)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///     - entry:
    ///
    convenience init(_ context: NSManagedObjectContext, from entry: RunningEntry) {
        self.init(context, name: entry.name, start: entry.start, project: entry.project, tags: entry.tags)
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var interval: DateInterval {
        get {
            DateInterval(start: start, end: end)
        }
        set {
            start = newValue.start
            end = newValue.end
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public override var duration: TimeInterval {
        get { interval.duration }
        set { interval.duration = newValue }
    }

}
