//
//  TreePicker.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-12.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: TreePicker

/// Undocumented.
///
/// - Todo: Document.
///
struct TreePicker<Entity: NSManagedObject & Tree>: View {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - entity:
    ///     - title:
    ///     - content:
    ///
    init<Content: View>(
            entity: Binding<ManagedEntity<Entity>>,
            title: String = Entity.entityName,
            @ViewBuilder content: @escaping () -> Content) {
        _entity = entity
        self.title = title
        self.content = { AnyView(content()) }
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    @Binding @ManagedEntity var entity: Entity?

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let title: String

    var body: some View {
        NavigationLink(destination: TreeView(entity: $entity).navigationBarTitle(title)) { content() }
    }

    // MARK: - Methods

    /// Undocumented
    ///
    /// - Todo: Document
    ///
    var content: () -> AnyView

}


// MARK: TreePicker_Previews

/// Undocumented.
///
/// - Todo: Document
///
class TreePicker_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        let project: Binding<ManagedEntity<Project>>
                = try! .constant(ManagedEntity(moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }))
        NavigationView {
            List {
                TreePicker(entity: project) {
                    ProjectView(project: project.wrappedValue.wrappedValue)
                }
            }
        }
                .environment(\.managedObjectContext, moc)
    }

}
