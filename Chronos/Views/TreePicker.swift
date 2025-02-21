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

struct TreePicker<Entity: NSManagedObject & Tree>: View {

    // MARK: - Life cycle methods

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

    @Binding var entity: Entity?

    let title: String

    let hiddenEntities: [Entity]

    var body: some View {
        NavigationLink(
                destination: TreeView(entity: $entity, hiddenEntities: hiddenEntities).navigationBarTitle(title)
        ) {
            content()
        }
    }

    // MARK: - Methods

    var content: () -> AnyView

}


// MARK: TreePicker_Previews

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
