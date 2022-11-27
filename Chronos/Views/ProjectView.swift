//
//  ProjectView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-06.
//
//

import Foundation
import SwiftUI


// MARK: ProjectView

/// Undocumented.
///
/// - Todo: Document.
///
struct ProjectView: View {

    // MARK: - Properties

    /// The Project being shown by this View.
    ///
    @ObservedObject @ManagedEntity var project: Project?

    var body: some View {
        VStack {
            HStack {
                Label("Project", systemImage: "at")
                Spacer()
                Text(project?.name ?? "No Project")
            }
                    .accessibilityElement(children: .combine)
            if let parent = project?.parent {
                Divider()
                HStack {
                    Label("Folder", systemImage: "folder")
                    Spacer()
                    Text(parent.name)
                }
                        .accessibilityElement(children: .combine)
            }
            if let theme = project?.theme {
                Divider()
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    ThemeView(theme: theme)
                }
                        .accessibilityElement(children: .combine)
            }
        }
    }

}


// MARK: ProjectView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class ProjectView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        NavigationView {
            List { try! ProjectView(project: moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!) }
        }
    }

}