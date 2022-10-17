//
//  EntryTagsEditView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-04.
//
//

import Foundation
import SwiftUI


// MARK: EntryTagsEditView

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryTagsEditView: View {

    // MARK: - Properties

    /// The Set of Tags being edited.
    ///
    @Binding
    var tags: Set<Tag>

    @Environment(\.managedObjectContext)
    private var moc

    @State
    private var newTagPath = ""

    var body: some View {
        ForEach(tags.sorted(by: \.path)) { tag in
            HStack {
                Image(systemName: "number")
                        .foregroundColor(.accentColor)
                Text(tag.path)
                        .multilineTextAlignment(.leading)
            }
        }
                .onDelete(perform: deleteTags)
        HStack {
            Image(systemName: "number")
                    .foregroundColor(.accentColor)
            TextField("New Tag", text: $newTagPath)
                    .multilineTextAlignment(.leading)
            Button(action: addTag) {
                Image(systemName: "plus.circle.fill")
                        .accessibilityLabel("Add Tag")
            }
                    .opacity(newTagPath.isEmpty ? 0 : 1)
        }
    }

    // MARK: - Methods

    private func addTag() {
        withAnimation {
            guard newTagPath != "" else { return }
            let tag = Tag.build(moc, fromPath: newTagPath)
            newTagPath = ""
            tags.insert(tag)
        }
    }

    private func deleteTags(offsets: IndexSet) {
        withAnimation {
            offsets
                    .map { tags.sorted(by: \.path)[$0] }
                    .forEach(moc.delete)
        }
    }
}

struct TagsEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                try! EntryTagsEditView(tags: .constant(Set(moc.fetch(Tag.makeFetchRequest()))))
                        .environment(\.managedObjectContext, moc)
            }
        }
    }
}
