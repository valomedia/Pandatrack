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

struct TagDetailView: View {

    // MARK: - Life cycle methods

    init(tag: Tag) {
        self._entries = FetchRequest(
                sortDescriptors: [SortDescriptor(\.start, order: .reverse)],
                predicate: NSPredicate(format: "ANY tags == %@", tag as CVarArg))
        self.tag = tag
    }

    // MARK: - Properties

    /// The Tag being shown by this View.
    ///
    @ObservedObject var tag: Tag

    var body: some View {
        List {
            Section {
                HStack {
                    Label("Name", systemImage: "number")
                    TextField("Tag Name", text: $tag.name)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: tag.name) { newValue in
                                tag.name = newValue.replacingOccurrences(of: Tag.pathSeparator, with: "")
                            }
                }
                ParentPicker<Tag>(entity: tag) {
                    ParentView(entity: tag.parent)
                }
            }
            Section {
                DeleteButton(
                        buttonText: "Delete Tag",
                        confirmationQuestion: "Do you really want to delete this tag?",
                        supplementalMessage: """
                                             This tag will be removed along with any subtags.  The tags will \
                                             be removed from their respective entries, but the entries \
                                             themselves will remain.
                                             """) {
                    moc.delete(tag)
                    dismiss()
                }
            }
            ChildrenView(entity: tag) { tag in
                TagDetailView(tag: tag)
            } header: {
                Label("Subtags", systemImage: "folder")
            }
            if !entries.isEmpty {
                EntriesView(entries: AnyRandomAccessCollection(entries), isPrimaryContentForSharing: true)
            }
        }
                .navigationBarTitle(tag.name)
    }

    @FetchRequest private var entries: FetchedResults<CompletedEntry>

    @Environment(\.managedObjectContext)
    private var moc

    @Environment(\.dismiss)
    private var dismiss

}


// MARK: TagDetailView_Previews

class TagDetailView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            try! TagDetailView(tag: moc.fetch(Tag.makeFetchRequest()).first { $0.name == "Foo" }!)
                    .environment(\.managedObjectContext, moc)
        }
    }

}
