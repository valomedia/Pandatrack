//
//  ChronosEnvironment.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-23.
//
//

import Foundation
import CoreData


// MARK: ChronosEnvironment

/// Undocumented.
///
/// - Todo: Document.
///
class ChronosEnvironment: ObservableObject {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static let preview: ChronosEnvironment? = {
        let ctx = PersistenceController.preview?.container.viewContext
        let env = ctx.map(ChronosEnvironment.init)
        try? env?.startEntry(
                continueFrom: Set(ctx?.fetch(Entry.makeFetchRequest()) ?? [])
                        .first { $0.name == "Take over the world!" })
        return env
    }()

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }

    // MARK: - Properties

    private var context: NSManagedObjectContext
    private var dispatchWorkItem: DispatchWorkItem?

    /// The Theme to use.
    ///
    var theme: Theme {
        EntryTimer.shared.entry?.theme ?? Theme.none
    }

    // MARK: - Methods

    /// Save changes to the context.
    ///
    /// This provides a debounced version of NSManagedObjectContext.save() for use across the application.
    ///
    /// - Todo: Exception handing
    ///
    func save() {
        let dispatchWorkItem = DispatchWorkItem { [weak self] in
            do {
                try self?.context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self?.dispatchWorkItem = nil
        }
        self.dispatchWorkItem?.cancel()
        self.dispatchWorkItem = dispatchWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: dispatchWorkItem)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    func startEntry(continueFrom entry: Entry?) {
        EntryTimer.shared.track(
                Entry(
                        context,
                        name: entry?.name ?? "",
                        start: Date(),
                        project: entry?.project,
                        tags: entry?.tags))
        save()
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    func startEntry() {
        startEntry(continueFrom: nil)
    }

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    func stopEntry() {
        EntryTimer.shared.reset()
        save()
    }

}