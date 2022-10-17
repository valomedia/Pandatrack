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
    ///     - content:
    ///
    init<Content: View>(entity: Binding<Entity?>, @ViewBuilder content: @escaping () -> Content) {
        _entity = entity
        self.content = { AnyView(content()) }
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    @Binding var entity: Entity?

    var body: some View {
        NavigationLink(
                destination: TreeView(
                        entity: Binding(
                                get: { entity },
                                set: { newValue in
                                    entity = newValue
                                    isPresentingTreePicker = false
                                }))
                        .navigationBarTitle(Entity.entityName),
                isActive: $isPresentingTreePicker) {
            content()
        }
    }

    @State private var isPresentingTreePicker = false

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
        let project: Binding<Project?>
                = try! .constant(moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!)
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
