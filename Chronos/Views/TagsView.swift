//
//  TagsView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-06.
//
//

import Foundation
import SwiftUI


// MARK: TagsView

/// Undocumented.
///
/// - Todo: Document.
///
struct TagsView: View {

    // MARK: - Properties

    /// The Tags being shown by this View.
    ///
    @ManagedEntities var tags: AnyRandomAccessCollection<Tag>

    var body: some View {
        ForEach(tags) { tag in
            Label(tag.path, systemImage: "number")
        }
    }

}


// MARK: TagsView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class TagsView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List {
                try! TagsView(tags: ManagedEntities(AnyRandomAccessCollection(moc.fetch(Tag.makeFetchRequest()))))
            }
        }
    }

}