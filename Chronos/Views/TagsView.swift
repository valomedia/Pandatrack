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

struct TagsView: View {

    // MARK: - Properties

    /// The Tags being shown by this View.
    ///
    let tags: AnyRandomAccessCollection<Tag>

    var body: some View {
        ForEach(tags) { tag in TagView(tag: tag) }
    }

}


// MARK: TagsView_Previews

class TagsView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List { try! TagsView(tags: AnyRandomAccessCollection(moc.fetch(Tag.makeFetchRequest()))) }
        }
    }

}
