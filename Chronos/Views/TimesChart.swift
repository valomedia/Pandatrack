//
//  TimesChart.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-07.
//
//

import Foundation
import SwiftUI
import Charts
import ObservedOptionalObject


// MARK: TimesChart

/// Undocumented.
///
/// - Todo: Document.
///
struct TimesChart: View {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    init(entries: AnyRandomAccessCollection<CompletedEntry>, interval: DateInterval, project: Project? = nil) {
        _subProjects = FetchRequest(
                sortDescriptors: [SortDescriptor(\.name)],
                predicate: NSPredicate(format: "parent == %@", project ?? 0 as CVarArg)
        )
        self.entries = entries
        self.interval = interval
        _project = ObservedOptionalObject(wrappedValue: project)
    }

    // MARK: - Properties

    /// The Entries being shown by this Chart.
    ///
    let entries: AnyRandomAccessCollection<CompletedEntry>

    /// The DateInterval being shown by this Chart.
    ///
    let interval: DateInterval

    /// The Project the Chart is filtered by, if any.
    ///
    @ObservedOptionalObject var project: Project?

    var body: some View {
        Wrapper {
            Chart(entries) { entry in
                if entry.start.day == entry.end.day {
                    RectangleMark(
                            x: .value("Day", entry.start.day, unit: .day),
                            yStart: .value("Start time", (entry.start - entry.start.day).hours),
                            yEnd: .value("End time", (entry.end - entry.start.day).hours)
                    )
                            .foregroundStyle(
                                    by: .value(
                                            "Folder",
                                            entry
                                                    .project?
                                                    .path
                                                    .dropFirst(project?.path.count ?? 0)
                                                    .split(separator: Project.pathSeparator)
                                                    .first
                                                    .map(String.init)
                                                    ?? (project != nil ? project!.name : "Other"))
                            )
                }
            }
                    .chartXScale(domain: interval.start...interval.end)
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .day)) {
                            AxisGridLine()
                            AxisValueLabel(format: .dateTime.weekday(.abbreviated))
                        }
                    }
                    .chartYScale(domain: 0...24)
                    .chartYAxis {
                        AxisMarks(position: .leading, values: [6, 12, 18]) { value in
                            AxisValueLabel { Text("\(value.as(Int.self)!):00") }
                            AxisGridLine()
                        }
                    }
                    .chartLegend(.hidden)
        }
                .if(!subProjects.map(\.theme).compacted().isEmpty) { view in
                    view.chartForegroundStyleScale { category in
                        subProjects.first { $0.name == category }?.theme?.backgroundColor ?? .accentColor
                    }
                }
                .padding([.horizontal])
    }

    @FetchRequest private var subProjects: FetchedResults<Project>

}


// MARK: TimesChart_Previews

class TimesChart_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        List {
            try? TimesChart(
                    entries: AnyRandomAccessCollection(moc.fetch(CompletedEntry.makeFetchRequest()).sorted(by: \.start)),
                    interval: .sevenDays
            )
                    .environment(\.managedObjectContext, moc)
        }
    }

}
