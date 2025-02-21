//
//  TagsTab.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-29.
//
//

import Foundation
import SwiftUI


// MARK: TagsTab

struct TagsTab: View {

    // MARK: - Properties

    var body: some View {
        NavigationView {
            TreeView<Tag>(depth: 2) { tag in TagDetailView(tag: tag) }
                    .navigationTitle("Tags")
                    .floatingActionButton { isPresentingNewTag = true }
                    .modal("New Tag", isPresented: $isPresentingNewTag, onOpen: { newTag = Tag(moc) }) {
                        if let newTag { TagDetailView(tag: newTag) }
                    }
        }
    }

    /// The new Tag being created, if any.
    ///
    @State private var newTag: Tag?

    /// Whether the sheet showing the TagDetailView is currently visible.
    ///
    @State private var isPresentingNewTag = false

    @Environment(\.managedObjectContext)
    private var moc

}


// MARK: TagsTab_Previews

class TagsTab_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        Group {
            TagsTab()
                    .environment(\.managedObjectContext, moc)
                    .environmentObject(env)
            TagsTab()
        }
    }

}
