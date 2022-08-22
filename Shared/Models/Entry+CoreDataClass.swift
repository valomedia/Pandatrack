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

///
/// - Todo: Document.
@objc(Entry)
public class Entry: NSManagedObject, Item {

    // MARK: - Life cycle methods

    @available(*, unavailable)
    public init() {
        fatalError("init() has not been implemented")
    }

    @available(*, unavailable)
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @available(*, unavailable)
    public init(context moc: NSManagedObjectContext) {
        super.init(entity: Self.entity(in: moc)!, insertInto: moc)
    }

    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///     - name:
    ///     - interval:
    ///     - project:
    ///     - tags:
    public init(
            _ context: NSManagedObjectContext,
            name: String,
            interval: DateInterval,
            project: Project? = nil,
            tags: Set<Tag>? = nil) {
        super.init(entity: Self.entity(in: context)!, insertInto: context)
        primitiveName = name
        primitiveStart = interval.start
        primitiveEnd = interval.end

        if let project = project {
            self.project = project
        }

        if let tags = tags {
            self.tags = tags
        }
    }

    // MARK: - Properties

    public var interval: DateInterval {
        get {
            DateInterval(start: start, end: end)
        }
        set {
            start = newValue.start
            end = newValue.end
        }
    }
}
