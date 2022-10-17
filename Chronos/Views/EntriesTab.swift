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

/// Undocumented.
///
/// - Todo: Document
///
struct EntriesTab: View {

    // MARK: - Properties

    var body: some View {
        NavigationView {
            Wrapper {
                if entries.isEmpty {
                    NoContentView(
                            title: "Welcome to Chronos!",
                            headline: "You Can Begin Tracking Your First Entry Right Away",
                            caption: """
                                     Tap the play button on the bottom right to start tracking. You can edit your \
                                     entry with the edit button to the left of the play button.

                                     Once you are happy with your entry, you can stop it with the stop button, that \
                                     shows up when an entry is running. Use the next entry button to stop an entry \
                                     end immediately begin the next one.
                                     """)
                } else {
                    List {
                        EntriesView(entries: AnyRandomAccessCollection(entries))
                    }
                }
            }
                    .navigationTitle("Time Entries")
        }
    }

    @FetchRequest(
            sortDescriptors: [SortDescriptor(\.start, order: .reverse)],
            predicate: NSPredicate(format: "end != nil"),
            animation: .default)
    private var entries: FetchedResults<Entry>

}

// MARK: EntriesTab_Previews

/// Undocumented.
///
/// - Todo: Document
///
class EntriesTab_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        Group {
            EntriesTab()
                    .environment(\.managedObjectContext, moc)
                    .environmentObject(env)
            EntriesTab()
        }
    }
}
