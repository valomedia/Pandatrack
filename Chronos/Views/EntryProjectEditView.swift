//
//  EntryProjectEditView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-10.
//
//

import Foundation
import SwiftUI


// MARK: EntryProjectEditView

struct EntryProjectEditView: View {

    // MARK: - Properties

    @Binding var project: Project?

    var body: some View {
        TreePicker(entity: $project) {
            ProjectView(project: project)
        }
    }

}


// MARK: EntryProjectEditView_Previews

class EntryProjectEditView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List {
                try! EntryProjectEditView(
                        project: .constant(moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" })
                )
            }
        }
    }

}
