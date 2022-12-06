//
//  ReportView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation
import SwiftUI


// MARK: ReportView

/// Undocumented.
///
/// - Todo: Document.
///
struct ReportView: View {

    // MARK: - Life cycle methods

    init(interval: DateInterval, project: Project? = nil, tag: Tag? = nil) {
        _entries = FetchRequest(
                sortDescriptors: [SortDescriptor(\.start)],
                predicate: NSPredicate(
                        format: "start > %@ AND start < %@",
                        interval.start as CVarArg,
                        interval.end as CVarArg)
        )
        self.project = project
        self.tag = tag
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @ManagedEntity var project: Project?

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @ManagedEntity var tag: Tag?

    var body: some View {
        ReportDetailView(
                entries: entries.filter { entry in
                    (tag == nil || entry.tags.contains(where: { $0.path.starts(with: tag?.path ?? "") }))
                            && (project == nil || entry.project!.path.starts(with: project?.path ?? ""))
                })
    }

    @FetchRequest private var entries: FetchedResults<CompletedEntry>

    @Environment(\.managedObjectContext)
    private var moc

}


// MARK: ReportView_Previews

class ReportView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        List {
            ReportView(interval: .lastSevenDays)
        }
    }

}