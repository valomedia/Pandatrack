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
    @ObservedObject @ManagedEntity var project: Project?

    var body: some View {
        if let _project = Binding<Project>($project.entity) {
            Form {
                HStack {
                    Label("Name", systemImage: "at")
                    TextField("Project Name", text: _project.name)
                            .multilineTextAlignment(.trailing)
                }
                ThemePicker(selection: $project.entity[\.theme])
                ParentPicker<Project>(entity: project) { ParentView(entity: project?.parent) }
            }
        } else {
            EmptyView()
        }
    }

    @FetchRequest()
    private var projects: FetchedResults<Project>

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
            try! ProjectDetailEditView(project: moc.fetch(Project.makeFetchRequest()).first {$0.name == "ACME"})
                    .environment(\.managedObjectContext, moc)
        }
    }

}
