//
//  ChildrenView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-01-17.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: ChildrenView

struct ChildrenView<Entity: NSManagedObject & Tree, Header: View, Content: View>: View {

    // MARK: - Life cycle methods

    init(entity: Entity, @ViewBuilder content: @escaping (Entity) -> Content, header: @escaping () -> Header) {
        self.header = header
        self.entity = entity
        self.content = content
    }

    // MARK: - Properties

    let entity: Entity

    var body: some View {
        if entity.children.isEmpty {
            EmptyView()
        } else {
            Section(header: header()) {
                ForEach(entity.children.sorted(by: \.name)) { entity in
                    NavigationLink {
                        content(entity)
                    } label: {
                        Label(entity.name, systemImage: "arrow.turn.down.right")
                    }
                }
            }
        }
    }

    // MARK: - Methods

    let content: (Entity) -> Content

    let header: () -> Header

}


// MARK: + init

extension ChildrenView where Header == Text {

    init<S>(_ text: S, entity: Entity, content: @escaping (Entity) -> Content) where S: StringProtocol {
        self.init(entity: entity, content: content) { Text(text) }
    }

    init(_ text: LocalizedStringKey, entity: Entity, content: @escaping (Entity) -> Content) {
        self.init(entity: entity, content: content) { Text(text) }
    }

}


// MARK: ChildrenView_Previews

class ChildrenView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List {
                try! ChildrenView(
                        "Subprojects",
                        entity: moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!
                ) { project in
                    ProjectDetailView(project: project)
                }
            }
        }
    }

}
