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

    private static let relativeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()

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
    convenience init(
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
    convenience init(_ context: NSManagedObjectContext, continueFrom entry: Entry) {
        self.init(context, name: entry.name, start: Date(), project: entry.project, tags: entry.tags)
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var interval: DateInterval {
        get {
            DateInterval(start: start, end: end ?? Date())
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
    @objc public var running: Bool {
        end == nil
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
        Self.relativeDateFormatter.string(from: start)
    }

}
