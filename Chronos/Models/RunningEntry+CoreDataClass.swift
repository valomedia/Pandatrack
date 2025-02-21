//
//  RunningEntry+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: RunningEntry

@objc(RunningEntry)
class RunningEntry: Entry {

    // MARK: - Life cycle methods

    convenience init(
            _ context: NSManagedObjectContext,
            name: String? = nil,
            start: Date? = nil,
            project: Project? = nil,
            tags: Set<Tag>? = nil
    ) {
        self.init(entity: Self.entity(in: context)!, insertInto: context)
        primitiveName = name ?? ""
        primitiveStart = start ?? Date()

        if let project = project { self.project = project }
        if let tags = tags { self.tags = tags }
    }

    convenience init(_ context: NSManagedObjectContext, continueFrom entry: CompletedEntry) {
        self.init(context, name: entry.name, start: Date(), project: entry.project, tags: entry.tags)
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
