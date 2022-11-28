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
            if let history = project?.entries.map({ entry in entry as? CompletedEntry }).compacted(), !history.isEmpty {
                Section(header: Text("History")) {
                    EntriesView(
                            entries: ManagedEntities(AnyRandomAccessCollection(history.sorted(by: \.start).reversed())))
                }
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
