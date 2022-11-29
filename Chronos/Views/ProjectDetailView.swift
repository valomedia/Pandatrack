//
//  ProjectDetailView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-12.
//
//

import Foundation
import SwiftUI


// MARK: ProjectDetailView

/// Undocumented.
///
/// - Todo: Document.
///
struct ProjectDetailView: View {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - project:
    ///
    init(project: Project?) {
        self._entries = FetchRequest(
                sortDescriptors: [SortDescriptor(\.start, order: .reverse)],
                predicate: NSPredicate(format: "project == %@", project ?? 0 as CVarArg))
        self.project = project
    }

    // MARK: - Properties

    /// The Project being shown by this View.
    ///
    @State @ManagedEntity var project: Project?

    var body: some View {
        List {
            Section { ProjectView(project: project) }
                    .contentShape(Rectangle())
                    .onTapGesture { isPresentingEditView = true }
            Section {
                DeleteButton(
                        buttonText: "Delete Project",
                        confirmationQuestion: "Do you really want to delete this Project?",
                        supplementalMessage: """
                                             This will remove the project and all subprojects along with their \
                                             respective entries.
                                             """) {
                    project.map(moc.delete)
                }
            }
            if !entries.isEmpty {
                Section(header: Text("Entries")) { EntriesView(entries: AnyRandomAccessCollection(entries)) }
            }
        }
                .navigationTitle(project?.name ?? "")
                .toolbar {
                    Button("Edit") { isPresentingEditView = true }
                }
                .modal(project?.name, isPresented: $isPresentingEditView) {
                    ProjectDetailEditView(project: project)
                }
    }

    @State private var isPresentingEditView = false

    @Environment(\.managedObjectContext)
    private var moc

    @FetchRequest private var entries: FetchedResults<CompletedEntry>

}


// MARK: ProjectDetailView_Previews

/// Undocumented.
///
/// - Todo: Document
///
class ProjectDetailView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            try! ProjectDetailView(project: moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" })
                    .environment(\.managedObjectContext, moc)
        }
    }

}
