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
    public init(
            _ context: NSManagedObjectContext,
            name: String? = nil,
            start: Date? = nil,
            end: Date? = nil,
            project: Project? = nil,
            tags: Set<Tag>? = nil
    ) {
        super.init(entity: Self.entity(in: context)!, insertInto: context)
        primitiveName = name ?? ""
        primitiveStart = start ?? Date()
        primitiveEnd = end

        if let project = project {
            self.project = project
        }

        if let tags = tags {
            self.tags = tags
        }
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
    public convenience init(
            _ context: NSManagedObjectContext,
            name: String?,
            interval: DateInterval?,
            project: Project? = nil,
            tags: Set<Tag>? = nil
    ) {
        self.init(context, name: name, start: interval?.start, end: interval?.end, project: project, tags: tags)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///     - entry:
    ///
    public convenience init(_ context: NSManagedObjectContext, continueFrom entry: Entry) {
        self.init(context, name: entry.name, start: Date(), project: entry.project, tags: entry.tags)
    }

    // MARK: - Properties

    public var interval: DateInterval {
        get {
            DateInterval(start: start, end: end ?? Date())
        }
        set {
            start = newValue.start
            end = newValue.end
        }
    }

    public var running: Bool {
        end == nil
    }

    public var theme: Theme {
        project?.resolveTheme() ?? Theme.none
    }

}
