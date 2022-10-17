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
        _ = try? env?.startEntry(
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
        self.ctx = context
    }

    // MARK: - Properties

    /// The Theme to use.
    ///
    var theme: Theme {
        EntryTimer.shared.entry?.theme ?? Theme.none
    }

    /// Whether saving will currently await confirmation.
    ///
    /// This is set to true, whenever saving is temporarily suspended until the user elects to either confirm or
    /// discard the pending changes.
    ///
    @Published private(set) var waitingForConfirmation = false

    /// Undocumented
    ///
    /// - Todo: Document
    ///
    @Published var errorWrapper: ErrorWrapper?

    private var ctx: NSManagedObjectContext
    private var scheduledSaveAction: DispatchWorkItem?

    // MARK: - Methods

    /// Save changes to the context.
    ///
    /// This provides a debounced version of NSManagedObjectContext.save() for use across the application.
    /// waitForConfirmation() can be used to temporarily disable this function.  All calls will be silently ignored,
    /// halting rapid saving throughout the application and causing changes to accumulate, until they are either
    /// confirmed, or discarded.
    ///
    /// - Todo: Exception handling
    ///
    func save() {
        guard !waitingForConfirmation else { return }
        let scheduledSaveAction = DispatchWorkItem { [weak self] in
            do {
                try self?.ctx.save()
            } catch let error as NSError {
                //fatalError("Unresolved error \(error), \(error.userInfo)")
                self?.errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
            }
            self?.scheduledSaveAction = nil
        }
        self.scheduledSaveAction?.cancel()
        self.scheduledSaveAction = scheduledSaveAction
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: scheduledSaveAction)
    }

    /// Waits for confirmation before saving any further changes.
    ///
    /// This can be used to save all pending changes, then temporarily disable save() until additional changes are
    /// either confirmed with confirmChanges(), or discarded with discardChanges().
    ///
    /// - Todo: Exception handling
    ///
    func waitForConfirmation() {
        waitingForConfirmation = true
        scheduledSaveAction?.perform()
    }

    /// Confirm changes.
    ///
    /// This will save all changes made while waitingForConfirmation.
    ///
    func confirmChanges() {
        waitingForConfirmation = false
        save()
    }

    /// Rollback changes to the context.
    ///
    /// This will schedule an NSManagedObjectContext.rollback() to be executed.  Causing all changes made while
    /// waitingForConfirmation to be discarded.
    ///
    /// - Todo: Exception handling
    ///
    func discardChanges() {
        // Nothing to discard, or already being discarded.
        guard waitingForConfirmation else { return }

        DispatchQueue.main.async(execute: DispatchWorkItem { [weak self] in
            self?.waitingForConfirmation = false
            self?.ctx.rollback()
        })
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - entry:
    /// - Returns:
    ///
    @discardableResult func startEntry(continueFrom entry: Entry?) -> Entry {
        let entry = Entry(
                ctx,
                name: entry?.name ?? "",
                start: Date(),
                project: entry?.project,
                tags: entry?.tags)
        EntryTimer.shared.track(entry)
        save()
        return entry
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Returns:
    ///
    @discardableResult func startEntry() -> Entry {
        startEntry(continueFrom: nil)
    }

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Returns:
    ///
    @discardableResult func stopEntry() -> Entry? {
        let entry = EntryTimer.shared.entry
        EntryTimer.shared.reset()
        save()
        return entry
    }

}