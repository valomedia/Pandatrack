//
//  Persistence.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-07.
//
//

import Foundation
import CoreData


// MARK: PersistenceController

/// Undocumented.
///
/// - Todo: Document
///
struct PersistenceController {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static let preview: PersistenceController? = {
        #if DEBUG && targetEnvironment(simulator)
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        do {
            // Build sample data for all entities currently in use.  Order matters here, since the sample data has
            // implicit interdependencies.  This would be inexcusable in production code, but since these code paths
            // are only reached when running in DEBUG mode on the simulator, I feel like we can get away with it.
            Project.sampleData(for: viewContext)
            Tag.sampleData(for: viewContext)
            try Entry.sampleData(for: viewContext)
            try viewContext.save()
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        return result
        #else
        return nil
        #endif
    }()

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var shared: PersistenceController {
        preview ?? _shared
    }

    private static let _shared: PersistenceController = PersistenceController()

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - inMemory:
    ///
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Chronos")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    let container: NSPersistentContainer
}
