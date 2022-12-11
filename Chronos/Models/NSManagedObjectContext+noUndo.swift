//
//  NSManagedObjectContext+noUndo.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-25.
//
//

import Foundation
import CoreData


// MARK: NSManagedObjectContext

extension NSManagedObjectContext {

    // MARK: + noUndo

    /// Undocumented.
    ///
    /// - Todo Document.
    /// - Parameter:
    ///     - cb:
    /// - Returns:
    ///
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