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

    /// The Entries being shown by this View.
    ///
    let entries: AnyRandomAccessCollection<Entry>

    var body: some View {
        ForEach(entries) { entry in
            NavigationLink(destination: EntryDetailView(entry: entry)) {
                EntryView(entry: entry)
            }
                    .listRowBackground(entry.theme.backgroundColor)
        }
                .onDelete(perform: deleteEntries)
    }

    @Environment(\.managedObjectContext)
    private var moc

    @EnvironmentObject private var env: ChronosEnvironment

    // MARK: - Methods

    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            offsets
                    .map { entries[AnyIndex($0)] }
                    .forEach(moc.delete)
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

    static var previews: some View {
        NavigationView {
            List {
                try! EntriesView(
                        entries: AnyRandomAccessCollection(
                                moc.fetch(Entry.makeFetchRequest()).filter({ $0.end != nil }).sorted(by: \.start)))
                        .environment(\.managedObjectContext, moc)
                        .environmentObject(env)
            }
        }
    }

}
