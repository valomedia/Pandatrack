//
//  TagView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-29.
//
//

import Foundation
import SwiftUI


// MARK: TagView

/// Undocumented.
///
/// - Todo: Document.
///
struct TagView: View {

    // MARK: - Properties

    /// The Tag being shown by this View.
    ///
    @ObservedObject @ManagedEntity var tag: Tag?

    var body: some View {
        if let tag = tag {
            Label(tag.path, systemImage: "number")
        } else {
            EmptyView()
        }
    }

}


// MARK: TagView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class TagView_Previews: PreviewProvider {

    // MARK: Static properties

    static var previews: some View {
        NavigationView {
            List { try! TagView(tag: moc.fetch(Tag.makeFetchRequest()).first { $0.name == "Foo" }!) }
        }
    }

}