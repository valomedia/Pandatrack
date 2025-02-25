//
//  ReportView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation
import SwiftUI
import ObservedOptionalObject


// MARK: ReportView

struct ReportView: View {

    // MARK: - Life cycle methods

    init(interval: DateInterval) {
        _entries = FetchRequest(
                sortDescriptors: [SortDescriptor(\.start)],
                predicate: NSPredicate(
                        format: "start > %@ AND start < %@",
                        interval.start as CVarArg,
                        interval.end as CVarArg)
        )
        self.interval = interval
    }

    // MARK: - Properties

    let interval: DateInterval

    var body: some View {
        AmountsChart(entries: filteredEntries, interval: interval, project: project)
        Form {
            Section {
                TreePicker(entity: $project) { ProjectView(project: project, compact: true) }
                TreePicker(entity: $tag) { TagView(tag: tag) }
            }
            if(Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day <= 8) {
                Section {
                    TimesChart(entries: filteredEntries, interval: interval, project: project)
                }
            }
            if !filteredEntries.isEmpty {
                Section {
                    NavigationLink {
                        List {
                            EntriesView("Results", entries: filteredEntries, isPrimaryContentForSharing: true)
                        }
                                .navigationTitle("All Matched Entries")
                                .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label("Show All Entries", systemImage: "list.triangle")
                    }
                }
            }
        }
    }

    private var filteredEntries: AnyRandomAccessCollection<CompletedEntry> {
        AnyRandomAccessCollection(
                entries.filter { entry in
                    (tag == nil || entry.tags.contains(where: { $0.path.starts(with: tag?.path ?? "") }))
                            && (project == nil || (entry.project?.path.starts(with: project?.path ?? "") ?? false))
// Fixed issue with unexpected nil
                }
        )
    }

    @FetchRequest private var entries: FetchedResults<CompletedEntry>

    @State private var project: Project?
    @State private var tag: Tag?

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
