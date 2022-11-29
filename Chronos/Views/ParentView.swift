//
//  ParentView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-29.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: ParentView

/// Undocumented.
///
/// - Todo: Document.
///
struct ParentView<Entity: NSManagedObject & Tree>: View {

    // MARK: - Properties

    /// The Entity being shown by this View.
    ///
    @ObservedObject @ManagedEntity var entity: Entity?

    var body: some View {
        HStack {
            Label("Folder", systemImage: "folder")
            Spacer()
            Text(entity?.name ?? "None")
        }
                .accessibilityElement(children: .combine)
    }

}


// MARK: ParentView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class ParentView_Previews: PreviewProvider {

    // MARK: Static properties

    static var previews: some View {
        Group {
            NavigationView {
                List {
                    ParentView<Project>(entity: nil)
                }
            }
            NavigationView {
                List {
                    try! ParentView(entity: moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!)
                }
            }
            NavigationView {
                List {
                    try! ParentView(entity: moc.fetch(Tag.makeFetchRequest()).first { $0.name == "Foo"}!)
                }
            }
        }
    }

}