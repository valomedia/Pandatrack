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

struct ProjectDetailView: View {

    // MARK: - Life cycle methods

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
            Section {
                HStack {
                    Label("Name", systemImage: "at")
                    TextField("Project Name", text: $project.name)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: project.name) { newValue in
                                project.name = newValue.replacingOccurrences(of: Project.pathSeparator, with: "")
                            }
                }
                ParentPicker<Project>(entity: project) {
                    ParentView(entity: project.parent)
                }
                ThemePicker(selection: $project.theme)
            }
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
            ChildrenView(entity: project) { project in
                ProjectDetailView(project: project)
            } header: {
                Label("Subprojects", systemImage: "folder")
            }
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

class ProjectDetailView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            try! ProjectDetailView(project: moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!)
                    .environment(\.managedObjectContext, moc)
        }
    }

}
