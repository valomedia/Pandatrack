//
//  DayView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation
import SwiftUI
import CoreData
import ObservedOptionalObject


// MARK: DayView

/// Undocumented.
///
/// - Todo: Document.
///
struct DayView: View {

    // MARK: - Static properties

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()

    private static let dateCompontentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter
    }()

    // MARK: - Life cycle methods

    /// Undocumented
    ///
    /// - Todo: Document
    /// - Parameters
    ///     - day:
    ///
    init(interval day: DateInterval? = nil) {
        self.day = day ?? DateInterval.today

        let predicate: NSPredicate
        if let day = day {
            predicate = NSPredicate(format: "start > %@ && end < %@", day.start as NSDate, day.end as NSDate)
        } else {
            predicate = NSPredicate(format: "start > %@", Date.startOfToday as NSDate)
        }
        _entries = FetchRequest<CompletedEntry>(sortDescriptors: [SortDescriptor(\.start)], predicate: predicate)
    }

    // MARK: - Properties

    var body: some View {
        let totalTime: TimeInterval = entries.map(\.duration).sum()
        VStack {
            Circle()
                    .strokeBorder(lineWidth: 24)
                    .overlay {
                        Text(DayView.dateCompontentsFormatter.string(from: totalTime) ?? "")
                                .accessibility(hidden: true)
                                .ifNotNil(TimeInterval.formatter.string(from: totalTime)) {
                                    $0
                                            .accessibility(hidden: false)
                                            .accessibilityLabel("Total time tracked")
                                            .accessibilityValue($1)
                                }
                    }
                    .overlay {
                        ForEach(entries) { entry in
                            DateIntervalArc(interval: entry.interval, in: day, lineWidth: 24)
                                    .rotation(Angle(degrees: 90))
                                    .stroke(entry.theme.backgroundColor, lineWidth: 12)
                        }
                    }
                    .padding()
            List {
                if !entries.isEmpty {
                    ForEach(
                            Dictionary(grouping: entries, by: { $0.project })
                                    .mapValues { value in
                                        (
                                                entries: AnyRandomAccessCollection(value),
                                                timeInterval: value.map(\.duration).sum()
                                        )
                                    }
                                    .sorted(by: \.value.timeInterval)
                                    .reversed()
                                    .filter { key, _ in key != nil }
                                    as! [
                                        (
                                                key: Project,
                                                value: (
                                                        entries: AnyRandomAccessCollection<CompletedEntry>,
                                                        timeInterval: TimeInterval
                                                )
                                        )
                                    ],
                            id: \.key
                    ) { key, value in
                        let name = key.name
                        let (entries, timeInterval) = value

                        NavigationLink {
                            List {
                                EntriesView(entries: entries, isPrimaryContentForSharing: true)
                            }
                                    .navigationTitle(name)
                                    .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            HStack {
                                Label(name, systemImage: "at")
                                Spacer()
                                Text(DayView.dateCompontentsFormatter.string(from: timeInterval) ?? "")
                            }
                                    .accessibilityLabel(name)
                                    .ifNotNil(TimeInterval.formatter.string(from: timeInterval)) {
                                        $0.accessibilityValue($1)
                                    }
                        }
                    }
                    NavigationLink {
                        List {
                            EntriesView(
                                    "All Entries",
                                    entries: AnyRandomAccessCollection(entries),
                                    isPrimaryContentForSharing: true)
                        }
                                .navigationTitle("All Entries")
                                .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        HStack {
                            Label("All Entries", systemImage: "list.triangle")
                        }
                    }
                }
            }
        }
    }

    /// The day's time entries.
    ///
    /// This gets all time entries that started after the start of the day and ended before the day.
    ///
    @FetchRequest private var entries: FetchedResults<CompletedEntry>

    private let day: DateInterval

}


// MARK: DayView_Previews

/// Undocumented.
///
/// - Todo: Document
///
class DayView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        DayView(interval: .yesterday)
                .environment(\.managedObjectContext, moc)
                .background(entryTimer.theme.backgroundColor)
                .previewLayout(.sizeThatFits)
    }

}
