//
//  Project+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData
import OrderedCollections


// MARK: Project

/// Undocumented.
///
/// - Todo: Document.
///
@objc(Project)
public final class Project: NSManagedObject, Tree {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @available(*, unavailable)
    public init() {
        fatalError("init() has not been implemented")
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///   - entity:
    ///   - context:
    ///
    @available(*, unavailable)
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameter moc:
    ///
    @available(*, unavailable)
    public init(context moc: NSManagedObjectContext) {
        super.init(entity: Self.entity(in: moc)!, insertInto: moc)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///   - moc:
    ///   - name:
    ///   - theme:
    ///   - entries:
    ///   - parent:
    ///   - children:
    ///
    public init(
            _ moc: NSManagedObjectContext,
            name: String,
            theme: Theme? = nil,
            entries: Set<Entry>? = nil,
            parent: Project? = nil,
            @SetBuilder<Project>
            _ children: () -> Set<Project>? = { nil }) {
        super.init(entity: Self.entity(in: moc)!, insertInto: moc)
        primitiveName = name
        primitiveTheme = theme

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
            parent: Project? = nil,
            @SetBuilder<Project>
            _ children: () -> Set<Project>? = { nil }) {
        self.init(moc, name: name, theme: nil, entries: nil, parent: parent, children)
    }

    // MARK: - Methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    func resolveTheme() -> Theme? {
        theme ?? parent?.resolveTheme()
    }

}
