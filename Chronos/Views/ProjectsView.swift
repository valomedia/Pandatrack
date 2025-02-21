//
//  ProjectsView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-29.
//
//

import Foundation
import SwiftUI


// MARK: ProjectsView

struct ProjectsView: View {

    // MARK: - Properties

    /// The Projects being shown by this View.
    ///
    let projects: AnyRandomAccessCollection<Project>

    var body: some View {
        ForEach(projects) { project in ProjectView(project: project) }
    }

}


// MARK: ProjectsView_Previews

class ProjectsView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List { try! ProjectsView(projects: AnyRandomAccessCollection(moc.fetch(Project.makeFetchRequest()))) }
        }
    }

}
