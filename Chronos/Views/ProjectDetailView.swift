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
        }
    }

}
