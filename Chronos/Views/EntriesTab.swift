//
//  EntriesTab.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-12.
//
//

import Foundation
import SwiftUI


// MARK: EntriesTab

struct EntriesTab: View {

    // MARK: - Properties

    var body: some View {
        NavigationView {
            Wrapper {
                if entries.isEmpty {
                    NoContentView(
                            title: "Hi, I‘m Pandy!",
                            headline: "Nice to meet you.",
                            image: Image(uiImage: Asset.Images.Pandy.hiImPandy.image))
                } else {
                    List {
                        ForEach(entries) { section in
                            EntriesView(
                                    section != entries.first ? LocalizedStringKey(section.id) : "Recent",
                                    entries: AnyRandomAccessCollection(
                                            section.filter {
                                                ($0.name.range(of: search, options: .caseInsensitive) != nil)
                                                        || search.isEmpty
                                            }
                                    )
                            )
                        }
                    }
                }
            }
                    .searchable(text: $search)
                    .navigationTitle("Time Entries")
                    .floatingActionButton { isPresentingEditView = true }
                    .modal("New Entry", isPresented: $isPresentingEditView, onOpen: { newEntry = CompletedEntry(moc)}) {
                        if let newEntry { EntryDetailEditView(entry: newEntry) }
                    }
        }
    }

    /// The new Entry being created, if any.
    ///
    @State private var newEntry: CompletedEntry?

    /// Whether the sheet showing the EntryDetailEditView is visible.
    ///
    @State private var isPresentingEditView = false

    /// The current search term.
    ///
    @State private var search = ""

    @SectionedFetchRequest(
            sectionIdentifier: \.day,
            sortDescriptors: [SortDescriptor(\.start, order: .reverse)],
            animation: .default)
    private var entries: SectionedFetchResults<String, CompletedEntry>

    @Environment(\.managedObjectContext)
    private var moc

}


// MARK: EntriesTab_Previews

class EntriesTab_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        Group {
            EntriesTab()
                    .environment(\.managedObjectContext, moc)
                    .environmentObject(entryTimer)
            EntriesTab()
        }
    }

}
