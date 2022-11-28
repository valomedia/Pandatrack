//
//  ProjectsTab.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-12.
//
//

import Foundation
import SwiftUI


// MARK: ProjectsTab

/// Undocumented.
///
/// - Todo: Document.
///
struct ProjectsTab: View {

    // MARK: - Properties

    var body: some View {
        NavigationView {
            TreeView<Project> { project in ProjectDetailView(project: project) }
                    .navigationTitle("Projects")
                    .floatingActionButton { isPresentingEditView = true }
                    .modal("New Project", isPresented: $isPresentingEditView, onOpen: { newProject = Project(moc) }) {
                        ProjectDetailEditView(project: newProject)
                    }
        }
    }

    /// The new Project being created, if any.
    ///
    @State @ManagedEntity private var newProject: Project?

    /// Whether the sheet showing the ProjectDetailEditView is visible.
    ///
    @State private var isPresentingEditView = false

    @Environment(\.managedObjectContext)
    private var moc

}


// MARK: ProjectsTab_Previews

/// Undocumented
///
/// - Todo: Document
///
class ProjectsTab_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        ProjectsTab().environment(\.managedObjectContext, moc)
    }

}