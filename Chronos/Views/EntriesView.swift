//
//  EntriesView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-07.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: EntriesView

/// Undocumented.
///
/// - Todo: Document.
///
struct EntriesView: View {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        List {
            ForEach(entries) { entry in
                NavigationLink(destination: EntryDetailView(entry: .constant(entry))) {
                    EntryView(entry: entry)
                }
                        .listRowBackground(entry.theme.backgroundColor)
            }
                    .onDelete(perform: deleteEntries)
        }
                .navigationTitle("Time Entries")
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
                                .accessibilityLabel("New Entry")
                    }
                }
                .sheet(isPresented: $isPresentingNewEntryView) {
                    NavigationView {

                    }
                }
    }

    @Environment(\.managedObjectContext)
    private var viewContext

    @EnvironmentObject
    private var env: ChronosEnvironment

    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Entry.timestamp, ascending: true)],
            predicate: NSPredicate(format: "end != nil"),
            animation: .default)
    private var entries: FetchedResults<Entry>

    /// Whether the view for creating a new Entry is currently visible
    ///
    @State
    private var isPresentingNewEntryView = false

    // MARK: - Methods

    private func addEntry() {
        withAnimation {
            isPresentingNewEntryView = true
            env.save()
        }
    }

    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            offsets.map { entries[$0] }.forEach(viewContext.delete)
            env.save()
        }
    }
}

// MARK: EntriesView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class EntriesView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        EntriesView()
                .environment(\.managedObjectContext, PersistenceController.preview!.container.viewContext)
                .environmentObject(ChronosEnvironment.preview!)
    }
}
