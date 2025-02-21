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

@objc(CompletedEntry)
class CompletedEntry: Entry {

    // MARK: - Static properties

    static let defaultDuration: TimeInterval = Double(Settings.entryDurationPreference * 60)

    // MARK: - Life cycle methods

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

    convenience init(
            _ context: NSManagedObjectContext,
            name: String? = nil,
            interval: DateInterval,
            project: Project? = nil,
            tags: Set<Tag>? = nil
    ) {
        self.init(context, name: name, start: interval.start, end: interval.end, project: project, tags: tags)
    }

    convenience init(_ context: NSManagedObjectContext, from entry: RunningEntry) {
        self.init(context, name: entry.name, start: entry.start, project: entry.project, tags: entry.tags)
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Properties

    public override var interval: DateInterval {
        get {
            DateInterval(start: start, end: end)
        }
        set {
            start = newValue.start
            end = newValue.end
        }
    }

    public override var duration: TimeInterval {
        get { interval.duration }
        set { interval.duration = newValue }
    }

}
