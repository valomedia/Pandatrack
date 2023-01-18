//
//  ProjectView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-06.
//
//

import Foundation
import SwiftUI
import ObservedOptionalObject


// MARK: ProjectView

/// Undocumented.
///
/// - Todo: Document.
///
struct ProjectView: View {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - project:
    ///     - compact:
    ///
    init(project: Project?, compact: Bool = false) {
        _project = ObservedOptionalObject(wrappedValue: project)
        self.compact = compact
    }

    // MARK: - Properties

    /// The Project being shown by this View.
    ///
    @ObservedOptionalObject var project: Project?

    /// Whether to show the compact version of this View.
    ///
    let compact: Bool

    var body: some View {
        if compact {
            Label(project?.path ?? "No Project", systemImage: "at")
        } else {
            VStack {
                HStack {
                    Label("Project", systemImage: "at")
                    Spacer()
                    Text(project?.name ?? "No Project")
                }
                        .accessibilityElement(children: .combine)
                if let parent = project?.parent {
                    Divider()
                    ParentView(entity: parent)
                }
                if let theme = project?.theme {
                    Divider()
                    HStack {
                        Label("Theme", systemImage: "paintpalette").padding(.trailing)
                        ThemeView(theme: theme).padding(.leading)
                    }
                            .accessibilityElement(children: .combine)
                }
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