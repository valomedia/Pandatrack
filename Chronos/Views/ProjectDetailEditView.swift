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
    @ObservedObject var project: Project

    var body: some View {
            HStack {
                Label("Name", systemImage: "at")
                TextField("Project Name", text: $project.name)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: project.name) { newValue in
                            project.name = newValue.replacingOccurrences(of: Project.pathSeparator, with: "")
                        }
            }
            ParentPicker<Project>(entity: project) { ParentView(entity: project.parent) }
            ThemePicker(selection: $project.theme)
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
            List {
                try! ProjectDetailEditView(project: moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!)
                        .environment(\.managedObjectContext, moc)
            }
        }
    }

}
