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

    // MARK: - Life cycle methods

    init(tags: Binding<Set<Tag>>) {
        _tags = Binding(
                get: { ManagedEntities(AnyRandomAccessCollection(tags.wrappedValue.map{ $0 })) },
                set: { newValue in tags.wrappedValue = Set(newValue.wrappedValue) }
        )
    }

    // MARK: - Properties

    /// The Set of Tags being edited.
    ///
    @Binding @ManagedEntities var tags: AnyRandomAccessCollection<Tag>

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

    @Environment(\.managedObjectContext)
    private var moc

    @State
    private var newTagPath = ""

    // MARK: - Methods

    private func addTag() {
        withAnimation {
            guard newTagPath != "" else { return }
            let tag = Tag.build(moc, fromPath: newTagPath)
            newTagPath = ""
            tags = AnyRandomAccessCollection(tags + [tag])
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


// MARK: TagsEditView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
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
