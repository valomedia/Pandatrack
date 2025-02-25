//
//  AmountsChart.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-07.
//

import Foundation
import SwiftUI
import Charts
import ObservedOptionalObject

// A helper struct representing a daily segment for a given project.
struct DailySegment: Identifiable {
    let id = UUID()
    let day: Date
    let project: String
    let duration: TimeInterval
}

// MARK: AmountsChart

struct AmountsChart: View {

    // MARK: - Life cycle methods

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

    /// The DateInterval being shown by this Chart.
    let interval: DateInterval

    /// The Entries being shown by this Chart.
    let entries: AnyRandomAccessCollection<CompletedEntry>

    /// The Project the Chart is filtered by, if any.
    @ObservedOptionalObject var project: Project?

    var body: some View {
        VStack {
            HStack {
                Text("You have tracked **\(Int(ceil(totalDuration().hours)))** hours")
                Spacer()
                ShareLink(item: shareURL) {
                    Image(systemName: "square.and.arrow.up")
                }
                .enabled(pdfIsReady)
            }
            chart
        }
        .padding([.horizontal, .top])
    }

    private var shareURL: URL {
        let content = VStack {
            Text("Tracked Time" + (project != nil ? " – \(project!.name)" : ""))
                .font(.largeTitle)
            Text(DateIntervalFormatter.formatter.string(from: interval) ?? interval.description)
                .font(.title)
            chart.padding()
            table.padding()
        }
        .padding()
        .frame(
            width: CGFloat(Settings.paperSizePreference[0]),
            height: CGFloat(Settings.paperSizePreference[1])
        )
        let url = URL.documentsDirectory.appending(
            path: (project?.name ?? "Entries")
                + " from "
                + ISO8601DateFormatter.formatter.string(from: interval.start)
                + " to "
                + ISO8601DateFormatter.formatter.string(from: interval.end)
                + ".pdf"
        )

        DispatchQueue.main.async {
            ImageRenderer(content: content).render { size, render in
                var mediaBox = CGRect(
                    origin: .zero,
                    size: CGSize(width: Settings.paperSizePreference[0], height: Settings.paperSizePreference[1])
                )
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
            ForEach(subProjects) { project in
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
                Text(TimeInterval.formatter.string(from: totalDuration()) ?? "ERROR")
            }
            .fontWeight(.bold)
        }
    }


    private func totalDuration() -> TimeInterval {
        entries.map(\.duration).sum()
    }

    /// Groups entries by day and project, summing durations so that each day gets one bar.
    private var dailySegments: [DailySegment] {
        let calendar = Calendar.current
        // Group all entries by the day (start of day)
        let dailyGroups = Dictionary(grouping: entries) { entry in
            calendar.startOfDay(for: entry.start)
        }
        var segments: [DailySegment] = []
        for (day, dayEntries) in dailyGroups {
            // Within each day, group entries by project name.
            let projectGroups = Dictionary(grouping: dayEntries, by: { entry in
                entry.project?.name ?? "Other"
            })
            // Create a segment for each project that sums the durations.
            let segmentsForDay = projectGroups.map { (projectName, entries) -> DailySegment in
                let total = entries.map(\.duration).sum()
                return DailySegment(day: day, project: projectName, duration: total)
            }
            // Sort so that the biggest segment comes first.
            let sortedSegments = segmentsForDay.sorted { $0.duration > $1.duration }
            segments.append(contentsOf: sortedSegments)
        }
        // Sort by day so that days appear in order.
        segments.sort { (s1, s2) in
            if s1.day == s2.day {
                return s1.duration > s2.duration
            } else {
                return s1.day < s2.day
            }
        }
        return segments
    }

    /// The Chart view. Each day produces one bar that is segmented by project,
    /// with segments ordered.
    private var chart: some View {
        Wrapper {
            Chart {
                ForEach(dailySegments) { segment in
                    BarMark(
                        x: .value("Day", segment.day, unit: .day),
                        y: .value("Duration", segment.duration.hours)
                    )
                    .foregroundStyle(by: .value("Project", segment.project))
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.day().month(.abbreviated))
                }
            }
            .chartYAxis { AxisMarks(position: .leading) }
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
