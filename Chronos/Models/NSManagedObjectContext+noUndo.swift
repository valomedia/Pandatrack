//
//  NSManagedObjectContext+noUndo.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: NSManagedObjectContext

extension NSManagedObjectContext {

    // MARK: + noUndo

    @discardableResult func noUndo<T>(_ cb: () throws -> T) rethrows -> T {
        // Pause undo management.
        processPendingChanges()
        undoManager?.disableUndoRegistration()
        defer {
            processPendingChanges()
            undoManager?.enableUndoRegistration()
        }

        // Execute callback.
        return try cb()
    }

}
