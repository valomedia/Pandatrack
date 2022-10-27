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
final class Project: NSManagedObject, Tree {

    // MARK: - Life cycle methods

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
    convenience init(
            _ moc: NSManagedObjectContext,
            name: String,
            theme: Theme? = nil,
            entries: Set<Entry>? = nil,
            parent: Project? = nil,
            @SetBuilder<Project> _ children: () -> Set<Project>? = { nil }) {
        self.init(entity: Self.entity(in: moc)!, insertInto: moc)
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
    convenience init(
            _ moc: NSManagedObjectContext,
            name: String,
            parent: Project? = nil,
            @SetBuilder<Project> _ children: () -> Set<Project>? = { nil }) {
        self.init(moc, name: name, theme: nil, entries: nil, parent: parent, children)
    }

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
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
