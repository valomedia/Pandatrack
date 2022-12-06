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
        let moc = PersistenceController.preview?.container.viewContext
        let env = moc.map(ChronosEnvironment.init)
        return env
    }()

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - moc:
    ///
    init(_ moc: NSManagedObjectContext) {
        self.moc = moc
        NotificationCenter.default.addObserver(
                forNames: [
                    .NSUndoManagerDidUndoChange,
                    .NSUndoManagerDidRedoChange,
                    .NSUndoManagerDidCloseUndoGroup
                ],
                object: undoManager,
                queue: OperationQueue.main
        ) { [weak self] _ in
            guard let self else { return }
            self.canUndo = self.undoManager.canUndo
            self.canRedo = self.undoManager.canRedo
        }
    }

    // MARK: - Properties

    /// The UndoManager for the entire application.
    ///
    @Published
    private(set) var undoManager = UndoManager()

    /// Whether saving will currently await confirmation.
    ///
    @Published private(set) var waitingForConfirmation = false

    /// Undocumented
    ///
    /// - Todo: Document
    ///
    @Published var errorWrapper: ErrorWrapper?

    /// Whether there is anything to undo.
    ///
    @Published var canUndo = false

    /// Whether there is anything to redo.
    ///
    @Published var canRedo = false

    /// The string representation of whatever the user is currently looking at, for sharing.
    ///
    @Published var shareString: String? = nil

    private var moc: NSManagedObjectContext

    // MARK: - Methods

    /// Save changes to the context.
    ///
    /// This will save changes to the context and perform error-handling.
    ///
    /// - Todo: Exception handling
    ///
    func save() {
        moc.perform { [weak self] in
            do {
                try self?.moc.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    /// Marks the start of a bunch of changes that'll either be accepted or discarded as a whole.
    ///
    /// If waitingForConfirmation already, this will automatically confirmChanges() first.
    ///
    func waitForConfirmation() {
        if waitingForConfirmation { confirmChanges() }
        waitingForConfirmation = true
        undoManager.beginUndoGrouping()
    }

    /// Save all changes made while waitingForConfirmation.
    ///
    /// If not waitingForConfirmation, this is a no-op.
    ///
    func confirmChanges() {
        guard waitingForConfirmation else { return }
        waitingForConfirmation = false
        undoManager.endUndoGrouping()
    }

    /// Discard all changes made while waitingForConfirmation.
    ///
    /// If not waitingForConfirmation, this is a no-op.
    ///
    func discardChanges() {
        guard waitingForConfirmation else { return }
        waitingForConfirmation = false
        undoManager.endUndoGrouping()
        undo()
    }

    /// Undo the last operation.
    ///
    /// This performs the undo operations in the last top-level undo group (closing it automatically, if applicable)
    /// and records the operations on the redo stack as a single group.  If there is nothing to undo, this is a no-op.
    ///
    func undo() {
        undoManager.undo()
    }

    /// Redo the last undo.
    ///
    /// This performs the redo operations in the last redo group, recording them on the undo stack as a single group.
    /// If there is nothing to redo, this is a no-op.
    ///
    func redo() {
        undoManager.redo()
    }

}