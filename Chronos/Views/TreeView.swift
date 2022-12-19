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

    // MARK: - Static properties

    /// How long to wait to dismiss() the TreeView, after the user has made a selection.
    ///
    /// When the TreeView is displaying a Tree of Entities for the user to chose from, selecting an Entity will show the
    /// selection tick mark moving to the new Entity, followed by the TreeView dismissing itself. There is a short delay
    /// before the dismissal, to allow the user to visually register, that the change has been made.  This constant sets
    /// the length of that delay (in seconds).
    ///
    let dismissDelay = 0.1

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - entity:
    ///     - root:
    ///     - search:
    ///     - content:
    ///
    private init<Content: View>(
            entity: Binding<ManagedEntity<Entity>>?,
            root: Entity?,
            search: Binding<String>? = nil,
            content: ((Entity?) -> Content)?) {
        _entity = entity ?? .constant(ManagedEntity())
        self.root = root
        self.content = content.map { content in
            { entity in AnyView(content(entity)) }
        }
        _subtrees = FetchRequest(
                sortDescriptors: [SortDescriptor(\.name)],
                predicate: NSPredicate(format: "parent == %@", root ?? 0 as CVarArg)
        )
        _searchBinding = search
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

    /// The binding for the current search term.
    ///
    var searchBinding: Binding<String> { _searchBinding ?? $searchState }
    private var _searchBinding: Binding<String>? = nil

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
                                Button(action: { select() }) {
                                    Label("Clear \(Entity.entityName)", systemImage: "xmark.circle.fill")
                                }
                            }
                        }
                        if !filteredSubtrees.isEmpty {
                            Section(header: Text(root?.path ?? "")) {
                                ForEach(filteredSubtrees) { node in
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
                                                view.onTapGesture {
                                                    select(node)
                                                }
                                            }
                                            .ifNotNil(content) { label, destination in
                                                NavigationLink(destination: destination(node)) {
                                                    label
                                                }
                                            }
                                }
                            }
                        }

                        ForEach(subtrees) { subtree in
                            if (!subtree.children.isEmpty) {
                                TreeView(entity: $entity, root: subtree, search: searchBinding, content: content)
                            }
                        }
                    }
                            .if(root == nil) { content in
                                List { content }.searchable(text: searchBinding)
                            }
                }
            }
    }

    @Environment(\.managedObjectContext)
    private var moc

    @FetchRequest private var subtrees: FetchedResults<Entity>

    private var filteredSubtrees: [Entity] {
        subtrees.filter {
            ($0.path.range(of: searchBinding.wrappedValue, options: .caseInsensitive) != nil)
                    || searchBinding.wrappedValue.isEmpty
        }
    }

    @State(initialValue: "")
    private var searchState: String

    // MARK: - Methods

    @Environment(\.dismiss)
    private var dismiss

    private func select(_ entity: Entity? = nil) {
        _entity.wrappedValue = ManagedEntity(entity)
        DispatchQueue.main.asyncAfter(deadline: .now()+dismissDelay, execute: dismiss.callAsFunction)
    }
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
