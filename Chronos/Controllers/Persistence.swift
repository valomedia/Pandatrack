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

struct PersistenceController {

    // MARK: - Static properties

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
            try CompletedEntry.sampleData(for: viewContext)
            try viewContext.save()
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        return result
        #else
        return nil
        #endif
    }()

    static var shared: PersistenceController {
        isRunningUITests ? _shared : preview ?? _shared
    }

    private static let _shared: PersistenceController = PersistenceController()

    // MARK: - Life cycle methods

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Chronos")
        if inMemory { container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null") }
        if !inMemory && Self.shouldResetPersistentStore { resetPersistentStoreFiles() }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    // MARK: - Properties

    let container: NSPersistentContainer

    private static var isRunningUITests: Bool {
        ProcessInfo.processInfo.arguments.contains("--ui-testing")
    }

    private static var shouldResetPersistentStore: Bool {
        isRunningUITests && ProcessInfo.processInfo.arguments.contains("--reset-persistent-store")
    }

    // MARK: - Methods

    private func resetPersistentStoreFiles() {
        guard let storeURL = container.persistentStoreDescriptions.first?.url else { return }

        let storeFiles = [
            storeURL,
            URL(fileURLWithPath: "\(storeURL.path)-shm"),
            URL(fileURLWithPath: "\(storeURL.path)-wal")
        ]

        for url in storeFiles {
            try? FileManager.default.removeItem(at: url)
        }
    }

}
