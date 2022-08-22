//
//  Tag+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: Tag

///
/// - Todo: Document.
@objc(Tag)
public final class Tag: Node, Tree {

    // MARK: - Life cycle methods

    @available(*, unavailable)
    public override init(_ context: NSManagedObjectContext, name: String) {
        super.init(context, name: name)
    }

    ///
    /// - Todo: Document.
    /// - Parameters:
    ///   - context:
    ///   - name:
    ///   - entries:
    ///   - parent:
    ///   - children:
    public init(
            _ context: NSManagedObjectContext,
            name: String,
            entries: Set<Entry>? = nil,
            parent: Tag? = nil,
            @SetBuilder<Tag>
            _ children: () -> Set<Tag>? = { nil }) {
        super.init(context, name: name)

        if let entries = entries {
            self.entries = entries
        }

        if let parent = parent {
            self.parent = parent
        }

        if let children = children() {
            self.children = children
        }
    }
}
