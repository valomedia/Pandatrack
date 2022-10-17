//
//  ProjectDetailEditView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-06.
//
//

import Foundation
import SwiftUI


// MARK: ProjectDetailEditView

/// Undocumented.
///
/// - Todo: Document.
///
struct ProjectDetailEditView: View {

    // MARK: - Properties

    /// The Project being modified.
    ///
    @Binding
    var project: Project

    @FetchRequest()
    private var projects: FetchedResults<Project>

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        Form {
            Section("Project") {
                HStack {
                    Label("Name", systemImage: "at")
                    TextField("Project Name", text: $project.name)
                            .multilineTextAlignment(.trailing)
                }
                ThemePicker(selection: $project.theme)
            }
            Section("Folder") {
                ParentPicker<Project>(entity: $project) {
                    ProjectView(project: project.parent)
                }
            }
        }
    }
}

// MARK: ProjectDetailEditView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class ProjectDetailEditView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        NavigationView {
            try! ProjectDetailEditView(
                    project: .constant(moc.fetch(Project.makeFetchRequest()).first {$0.name == "ACME"}!))
                    .environment(\.managedObjectContext, moc)
        }
    }
}
