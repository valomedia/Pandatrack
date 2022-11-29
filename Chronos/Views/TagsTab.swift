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

/// Undocumented.
///
/// - Todo: Document.
///
struct TagsTab: View {

    // MARK: - Static properties

    // MARK: - Static methods

    // MARK: - Life cycle methods

    // MARK: - Properties

    var body: some View {
        NavigationView {
            TreeView<Tag> { tag in TagDetailView(tag: tag) }.navigationBarTitle("Tags")
        }
    }

    @Environment(\.managedObjectContext)
    private var moc

    // MARK: - Methods
}


// MARK: TagsTab_Previews

/// Undocumented.
///
/// - Todo: Document.
///
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