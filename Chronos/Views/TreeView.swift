//
//  TreeView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-10.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: TreeView

/// Undocumented.
///
/// - Todo: Document.
///
struct TreeView<Entity: NSManagedObject & Tree>: View {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - entity:
    ///     - root:
    ///     - content:
    ///
    private init<Content: View>(
            entity: Binding<ManagedEntity<Entity>>?,
            root: Entity?,
            content: ((Entity?) -> Content)?) {
        _entity = entity ?? .constant(nil)
        self.root = root
        self.content = content.map { content in
            { entity in AnyView(content(entity)) }
        }
        _subtrees = FetchRequest(
                sortDescriptors: [SortDescriptor(\.name)],
                predicate: NSPredicate(format: "parent == %@", root ?? 0 as CVarArg)
        )
    }

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - entity:
    ///     - root:
    ///     - content:
    ///
    init<Content: View>(
            root: Entity? = nil,
            @ViewBuilder content: @escaping (Entity?) -> Content) {
        self.init(entity: nil, root: root, content: content)
    }

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - entity:
    ///     - root:
    ///
    init(entity: Binding<ManagedEntity<Entity>>, root: Entity? = nil) {
        self.init(entity: entity, root: root, content: nil as ((Entity?) -> Never)?)
    }

    // MARK: - Properties

    /// The binding for the Entity that is selected.
    ///
    @Binding @ManagedEntity var entity: Entity?

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let root: Entity?

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let content: ((Entity?) -> AnyView)?

    var body: some View {
            Wrapper {
                if subtrees.isEmpty {
                    NoContentView(
                            title: "There Is Nothing Here",
                            headline: "You Have not Created Any \(Entity.entityName)s Yet.",
                            caption: "Create a new \(Entity.entityName.lowercased()) to get started.")
                } else {
                    Wrapper {
                        if (root == nil && content == nil) {
                            Section {
                                Button(action: { _entity.wrappedValue = ManagedEntity(nil) }) {
                                    Label("Clear \(Entity.entityName)", systemImage: "xmark.circle.fill")
                                }
                            }
                        }
                        Section(header: Text(root?.path ?? Entity.pathSeparator)) {
                            ForEach(subtrees) { node in
                                    HStack {
                                        Label(node.name, systemImage: "arrow.turn.down.right")
                                        Spacer()
                                        if (entity == node) {
                                            Image(systemName: "checkmark")
                                                    .foregroundColor(.accentColor)
                                        }
                                    }
                                            .contentShape(Rectangle())
                                            .if(content == nil) { view in
                                                view.onTapGesture { _entity.wrappedValue = ManagedEntity(node) }
                                            }
                                            .ifNotNil(content) { label, destination in
                                                NavigationLink(destination: destination(node)) { label }
                                            }
                            }
                        }
                        ForEach(subtrees) { subtree in
                            if (!subtree.children.isEmpty) {
                                TreeView(entity: $entity, root: subtree, content: content)
                            }
                        }
                    }
                            .if(root == nil) { content in
                                List { content }
                            }
                }
            }
    }

    @Environment(\.managedObjectContext)
    private var moc

    @FetchRequest private var subtrees: FetchedResults<Entity>

}


// MARK: TreeView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class TreeView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        Group {
            NavigationView {
                try! TreeView(
                        entity: .constant(
                                ManagedEntity(moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }))
                )
                        .environment(\.managedObjectContext, moc)
            }
        }
    }

}
