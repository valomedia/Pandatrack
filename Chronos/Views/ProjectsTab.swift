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
            TreeView<Project> { project in
                ProjectDetailView(project: project)
            }
                .navigationBarTitle("Projects")
        }
    }

}


// MARK: ProjectsTab_Previews

/// Undocumented
///
/// - Todo: Document
///
class ProjectsTab_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        ProjectsTab()
                .environment(\.managedObjectContext, moc)
                .environmentObject(env)
    }

}