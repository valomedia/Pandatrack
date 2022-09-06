//
//  ContentView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-06.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: ContentView

/**
 - Todo: Document.
 */
struct ContentView: View {

    // MARK: - Static properties

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

    // MARK: - Class methods

    // MARK: - Life cycle methods

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    var body: some View {
        NavigationView {
            List {
                ForEach(entries) { entry in
                    NavigationLink {
                        VStack {
                            Text(entry.name)
                            Text("Item at \(entry.timestamp, formatter: ContentView.dateFormatter)")
                        }
                    } label: {
                        Text(entry.name)
                    }
                }
                        .onDelete(perform: deleteEntries)
            }
                    .toolbar {
                        #if os(iOS)
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        #endif
                        ToolbarItem {
                            Button(action: addEntry) {
                                Label("Add Entry", systemImage: "plus")
                            }
                        }
                    }
        }
    }

    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Entry.timestamp, ascending: true)],
            animation: .default)
    private var entries: FetchedResults<Entry>

    // MARK: - Methods

    private func addEntry() {
        withAnimation {
            // Todo: Implement.
            // _ = Item(viewContext, name: "Hello, World!")

            do {
                try viewContext.save()
            } catch let error as NSError {
                // TODO: Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this
                // function in a shipping application, although it may be useful during development.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            offsets.map { entries[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch let error as NSError {
                // TODO: Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this
                // function in a shipping application, although it may be useful during development.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

/**
 - Todo: Document.
 */
class ContentView_Previews: PreviewProvider {

    // MARK: - Static properties

    /**
     - Todo: Document.
     */
    static var previews: some View {
        if let context = PersistenceController.preview?.container.viewContext {
            ContentView().environment(\.managedObjectContext, context)
        }
    }
}
