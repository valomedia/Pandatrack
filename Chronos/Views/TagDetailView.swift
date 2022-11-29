//
//  TagDetailView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-29.
//
//

import Foundation
import SwiftUI


// MARK: TagDetailView

/// Undocumented.
///
/// - Todo: Document.
///
struct TagDetailView: View {

    // MARK: - Static properties

    // MARK: - Static methods

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - tag:
    ///
    init(tag: Tag?) {
        self._entries = FetchRequest(
                sortDescriptors: [SortDescriptor(\.start, order: .reverse)],
                predicate: NSPredicate(format: "ANY tags == %@", tag ?? 0 as CVarArg))
        self.tag = tag
    }

    // MARK: - Properties

    /// The Tag being shown by this View.
    ///
    @State @ManagedEntity var tag: Tag?

    var body: some View {
        List {
            Section { TagView(tag: tag) }
            Section {
                DeleteButton(
                        buttonText: "Delete Tag",
                        confirmationQuestion: "Do you really want to delete this tag?",
                        supplementalMessage: """
                                             This tag will be removed along with any subtags.  The tags will be \
                                             removed from their respective entries, but the entries themselves will \
                                             remain.
                                             """) {
                    tag.map(moc.delete)
                }
            }
            if !entries.isEmpty {
                Section(header: Text("Entries")) { EntriesView(entries: AnyRandomAccessCollection(entries)) }
            }
        }
                .navigationBarTitle(tag?.name ?? "")
    }

    @FetchRequest private var entries: FetchedResults<CompletedEntry>

    @Environment(\.managedObjectContext)
    private var moc

}


// MARK: TagDetailView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class TagDetailView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            try! TagDetailView(tag: moc.fetch(Tag.makeFetchRequest()).first { $0.name == "Foo" }!)
                    .environment(\.managedObjectContext, moc)
        }
    }

}