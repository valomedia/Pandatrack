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
public class Entry: Item {

    // MARK: - Life cycle methods

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
        super.init(context, name: name)
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
