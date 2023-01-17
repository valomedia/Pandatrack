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
    ///     - depth:
    ///     - content:
    ///
    private init<Content: View>(
            entity: Binding<Entity?>?,
            root: Entity?,
            search: Binding<String>? = nil,
            depth: Int? = nil,
            content: ((Entity) -> Content)?) {
        _entity = entity ?? .constant(nil)
        self.root = root
        self.content = content.map { content in
            { entity in AnyView(content(entity)) }
        }
        self.depth = depth ?? Int.max
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
    ///     - depth:
    ///
    init<Content: View>(
            root: Entity? = nil,
            depth: Int? = nil,
            @ViewBuilder content: @escaping (Entity) -> Content) {
        self.init(entity: nil, root: root, depth: depth, content: content)
    }

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - entity:
    ///     - root:
    ///     - depth:
    ///
    init(entity: Binding<Entity?>, root: Entity? = nil, depth: Int? = nil) {
        self.init(entity: entity, root: root, depth: depth, content: nil as ((Entity) -> Never)?)
    }

    // MARK: - Properties

    /// The binding for the Entity that is selected.
    ///
    @Binding var entity: Entity?

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
    let content: ((Entity) -> AnyView)?

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let depth: Int

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
                            Section {
                                ForEach(filteredSubtrees) { node in
                                    HStack {
                                        Label(node.name, systemImage: root == nil ? "folder" : "arrow.turn.down.right")
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
                            } header: {
                                if let root { Label(root.path, systemImage: "folder") }
                            }
                        }

                        ForEach(subtrees) { subtree in
                            if (!subtree.children.isEmpty && depth > 1) {
                                TreeView(
                                        entity: $entity,
                                        root: subtree,
                                        search: searchBinding,
                                        depth: depth - 1,
                                        content: content)
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
        self.entity = entity
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
                        entity: .constant(moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" })
                )
                        .environment(\.managedObjectContext, moc)
            }
        }
    }

}
