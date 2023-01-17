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
    ///     - hiddenEntities:
    ///
    init<Content: View>(
            entity: Binding<Entity?>,
            title: String = Entity.entityName,
            hiddenEntities: [Entity]? = nil,
            @ViewBuilder content: @escaping () -> Content) {
        _entity = entity
        self.title = title
        self.hiddenEntities = hiddenEntities ?? []
        self.content = { AnyView(content()) }
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    @Binding var entity: Entity?

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let title: String

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let hiddenEntities: [Entity]

    var body: some View {
        NavigationLink(
                destination: TreeView(entity: $entity, hiddenEntities: hiddenEntities).navigationBarTitle(title)
        ) {
            content()
        }
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
        let project = try! Binding.constant(moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" })
        NavigationView {
            List {
                TreePicker(entity: project) {
                    ProjectView(project: project.wrappedValue)
                }
            }
        }
                .environment(\.managedObjectContext, moc)
    }

}
