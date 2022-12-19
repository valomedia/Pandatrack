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

    /// The DateInterval being shown by this Chart.
    ///
    let interval: DateInterval

    /// The Entries being shown by this Chart.
    ///
    let entries: AnyRandomAccessCollection<CompletedEntry>

    /// The Project the Chart is filtered by, if any.
    ///
    @ObservedObject @ManagedEntity var project: Project?

    var body: some View {
        VStack {
            HStack {
                Text("You have tracked **\(Int(ceil(sum().hours)))** hours")
                Spacer()
                ShareLink(item: shareURL) { Image(systemName: "square.and.arrow.up") }.enabled(pdfIsReady)
            }
            chart
        }
                .padding([.horizontal, .top])
    }

    private var shareURL: URL {
        let content = VStack {
            Text("Tracked Time" + (project != nil ? " – \(project!.name)" : "")).font(.largeTitle)
            Text(DateIntervalFormatter.formatter.string(from: interval) ?? interval.description).font(.title)
            chart.padding()
            table.padding()
        }
                .padding()
                .frame(
                        width: CGFloat(Settings.paperSizePreference[0]),
                        height: CGFloat(Settings.paperSizePreference[1]))
        let url = URL.documentsDirectory.appending(
                path: (project?.name ?? "Entries")
                        + " from "
                        + ISO8601DateFormatter.formatter.string(from: interval.start)
                        + " to "
                        + ISO8601DateFormatter.formatter.string(from: interval.end)
                        + ".pdf")

        DispatchQueue.main.async {
            ImageRenderer(content: content).render { size, render in
                var mediaBox = CGRect(
                        origin: .zero,
                        size: CGSize(width: Settings.paperSizePreference[0], height: Settings.paperSizePreference[1]))
                guard let pdf = CGContext(
                        url as CFURL,
                        mediaBox: &mediaBox,
                        [
                            kCGPDFContextCreator: Settings.namePreference,
                            kCGPDFContextTitle: (project?.name ?? "Entries")
                                    + " from "
                                    + (DateIntervalFormatter.formatter.string(from: interval) ?? interval.description)
                        ] as CFDictionary
                ) else {
                    return
                }
                pdf.beginPDFPage(nil)
                render(pdf)
                pdf.endPDFPage()
                pdf.closePDF()
                pdfIsReady = true
            }
        }
        return url
    }

    private var table: some View {
        VStack {
            HStack {
                Text("Project")
                Spacer()
                Text("Time spent")
            }
                    .font(.title2)
            Divider()
            ForEach(subProjects.map(ManagedEntity.init).map(\.wrappedValue).compacted()) { project in
                HStack {
                    Text(project.name)
                    Spacer()
                    Text(TimeInterval.formatter.string(from: sum(for: project)) ?? "ERROR")
                }
                Divider()
            }
            HStack {
                Text("Total")
                Spacer()
                Text(TimeInterval.formatter.string(from: sum()) ?? "ERROR")
            }
                    .fontWeight(.bold)
        }
    }

    private var chart: some View {
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

    private var unit: Calendar.Component {
        switch Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day {
        case .some(0...31): return .day
        case .some(32...92): return .weekOfYear
        case .some(93...366): return .month
        case .some(367...3660): return .quarter
        default: return .year
        }
    }

    @FetchRequest private var subProjects: FetchedResults<Project>

    @State private var pdfIsReady = false

    // MARK: - Methods

    private func sum(for project: Project? = nil) -> TimeInterval {
        entries
                .filter { project == nil || $0.project?.path.starts(with: project!.path) ?? false }
                .map(\.duration)
                .sum()
    }
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
