//
//  AmountsChart.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-07.
//
//

import Foundation
import SwiftUI
import Charts


// MARK: AmountsChart

/// Undocumented.
///
/// - Todo: Document.
///
struct AmountsChart: View {

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
        self.project = project
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
    @ManagedEntity var project: Project?

    var body: some View {
        VStack {
            Text("You have tracked **\(sum)** hours")
                    .frame(maxWidth: .infinity, alignment: .leading)
            Wrapper {
                Chart(entries) { entry in
                    BarMark(x: .value(unit.description, entry.start, unit: unit), y: .value("Time", entry.duration.hours))
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
                        .chartXScale(domain: interval.start...interval.end)
                        .chartXAxis {
                            Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day <= 7
                                    ? AxisMarks(values: .stride(by: .day))
                                    : AxisMarks()
                        }
                        .chartYAxis { AxisMarks(position: .leading) }
            }
                    .chartPlotStyle {
                        $0.border(.gray, width: 1)
                    }
                    .if(!subProjects.map(\.theme).compacted().isEmpty) { view in
                        view.chartForegroundStyleScale { category in
                            subProjects.first { $0.name == category }?.theme?.backgroundColor ?? .accentColor
                        }
                    }
        }
                .padding([.horizontal, .top])
    }

    private var unit: Calendar.Component {
        switch Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day {
        case .some(0...31): return .day
        case .some(32...92): return .weekOfYear
        case .some(93...366): return .month
        case .some(367...3660): return .quarter
        default: return .year
        }
    }

    private var sum: Int {
        Int(ceil(entries.map(\.duration).sum().hours))
    }

    @FetchRequest private var subProjects: FetchedResults<Project>

}


// MARK: AmountsChart_Previews

class AmountsChart_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        List {
            try? AmountsChart(
                    entries: AnyRandomAccessCollection(moc.fetch(CompletedEntry.makeFetchRequest()).sorted(by: \.start)),
                    interval: .sevenDays
            )
                    .environment(\.managedObjectContext, moc)
        }
    }

}
