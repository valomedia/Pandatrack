//
//  ParentPicker.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-12.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: ParentPicker

/// Undocumented.
///
/// - Todo: Document.
///
struct ParentPicker<Entity: NSManagedObject & Tree>: View {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - entity:
    ///     - content:
    ///
    init<Content: View>(entity: Entity, @ViewBuilder content: @escaping () -> Content) {
        self.entity = entity
        self.content = { AnyView(content()) }
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @ObservedObject var entity: Entity

    var body: some View {
        TreePicker(
                entity: Binding(
                        get: { entity.parent },
                        set: { newValue in
                            // If the new parent is descended from a child of this Entity, move the child to the root
                            // level, to resolve the circle.
                            if let newValue {
                                var parent = newValue
                                while let grandparent = parent.parent {
                                    if grandparent == entity {
                                        parent.parent = nil
                                    } else {
                                        parent = grandparent
                                    }
                                }
                            }

                            // If trying to make something its own parent, outright ignore the change (it should not be
                            // possible to actually cause this, since the Entity itself is hidden from the TreePicker).
                            guard newValue != entity else { return }
                            entity.parent = newValue
                        }),
                title: "Folder",
                hiddenEntities: [entity]
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


// MARK: ParentPicker_Previews

/// Undocumented.
///
/// - Todo: Document
///
class ParentPicker_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        let project: Project = try! moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!
        NavigationView {
            List {
                ParentPicker(entity: project) { ProjectView(project: project.parent) }
                        .environment(\.managedObjectContext, moc)
            }
        }
    }

}