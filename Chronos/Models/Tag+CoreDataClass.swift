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

@objc(Tag)
final class Tag: NSManagedObject, Tree {

    // MARK: - Life cycle methods

    convenience init(
            _ moc: NSManagedObjectContext,
            name: String? = nil,
            entries: Set<CompletedEntry>? = nil,
            parent: Tag? = nil,
            @SetBuilder<Tag> _ children: () -> Set<Tag>? = { nil }) {
        self.init(entity: Self.entity(in: moc)!, insertInto: moc)
        primitiveName = name ?? ""

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

    convenience init(
            _ moc: NSManagedObjectContext,
            name: String,
            parent: Tag? = nil,
            @SetBuilder<Tag> _ children: () -> Set<Tag>? = { nil }) {
        self.init(moc, name: name, entries: nil, parent: parent, children)
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
