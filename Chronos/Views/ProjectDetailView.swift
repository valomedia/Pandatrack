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
    init(project: Project) {
        self._entries = FetchRequest(
                sortDescriptors: [SortDescriptor(\.start, order: .reverse)],
                predicate: NSPredicate(format: "project == %@", project as CVarArg))
        self.project = project
    }

    // MARK: - Properties

    /// The Project being shown by this View.
    ///
    @ObservedObject var project: Project

    var body: some View {
        List {
            ProjectDetailEditView(project: project)
            Section {
                DeleteButton(
                        buttonText: "Delete Project",
                        confirmationQuestion: "Do you really want to delete this Project?",
                        supplementalMessage: """
                                             This will remove the project and all subprojects along with their \
                                             respective entries.
                                             """) {
                    moc.delete(project)
                }
            }
            ChildrenView("Subprojects", entity: project) { project in ProjectDetailView(project: project) }
            if !entries.isEmpty {
                EntriesView(entries: AnyRandomAccessCollection(entries), isPrimaryContentForSharing: true)
            }
        }
                .navigationTitle(project.name)
    }

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
            try! ProjectDetailView(project: moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!)
                    .environment(\.managedObjectContext, moc)
        }
    }

}
