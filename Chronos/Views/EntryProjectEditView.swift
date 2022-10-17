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

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryProjectEditView: View {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    @Binding var project: Project?

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    var body: some View {
        TreePicker(entity: $project) {
            ProjectView(project: project)
        }
    }

}


// MARK: EntryProjectEditView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class EntryProjectEditView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var previews: some View {
        NavigationView {
            List {
                try! EntryProjectEditView(
                        project: .constant(moc.fetch(Project.makeFetchRequest()).first { $0.name == "ACME" }!))
                        .environment(\.managedObjectContext, moc)
            }
        }
    }
}