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

/// Undocumented.
///
/// - Todo: Document.
///
@objc(Tag)
public final class Tag: NSManagedObject, Tree {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - moc:
    ///     - name:
    ///     - entries:
    ///     - parent:
    ///     - children:
    ///
    public init(
            _ moc: NSManagedObjectContext,
            name: String,
            entries: Set<Entry>? = nil,
            parent: Tag? = nil,
            @SetBuilder<Tag>
            _ children: () -> Set<Tag>? = { nil }) {
        super.init(entity: Self.entity(in: moc)!, insertInto: moc)
        primitiveName = name

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

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - moc:
    ///     - name:
    ///     - parent:
    ///     - children:
    ///
    public convenience init(
            _ moc: NSManagedObjectContext,
            name: String,
            parent: Tag? = nil,
            @SetBuilder<Tag>
            _ children: () -> Set<Tag>? = { nil }) {
        self.init(moc, name: name, entries: nil, parent: parent, children)
    }

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

}