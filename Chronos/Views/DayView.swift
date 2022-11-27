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

    // MARK: - Life cycle methods

    /// Undocumented
    ///
    /// - Todo: Document
    /// - Parameters
    ///     - day:
    ///
    init(_ day: DateInterval? = nil) {
        self.day = day ?? DateInterval.today

        let predicate: NSPredicate
        if let day = day {
            predicate = NSPredicate(format: "start > %@ && end < %@", day.start as NSDate, day.end as NSDate)
        } else {
            predicate = NSPredicate(format: "start > %@", Date.today as NSDate)
        }
        _entries = FetchRequest<CompletedEntry>(sortDescriptors: [SortDescriptor(\.start)], predicate: predicate)
    }

    // MARK: - Properties

    var body: some View {
        let totalTime = entries.map(\.interval.duration).sum()
        Circle()
                .strokeBorder(lineWidth: 24)
                .overlay {
                    Text(DateComponentsFormatter.briefTimeFormatter.string(from: totalTime) ?? "")
                            .accessibility(hidden: true)
                            .ifNotNil(DateComponentsFormatter.fullTimeFormatter.string(from: totalTime)) {
                                $0
                                        .accessibility(hidden: false)
                                        .accessibilityLabel("Total time tracked")
                                        .accessibilityValue($1)
                            }
                            .foregroundStyle(entryTimer.theme.foregroundColor)
                }
                .overlay {
                    ForEach(entries) { entry in
                        DateIntervalArc(interval: entry.interval, in: day, lineWidth: 24)
                                .rotation(Angle(degrees: 90))
                                .stroke(entry.theme.backgroundColor, lineWidth: 12)
                    }
                }
                .padding(.horizontal)
    }

    /// The day's time entries.
    ///
    /// This gets all time entries that started after the start of the day and ended before the day.
    ///
    @FetchRequest private var entries: FetchedResults<CompletedEntry>

    // This will cause the View to repaint every second while an Entry is running, which is really only necessary for
    // the TodayView, but there doesn't seem to be a trivial way to optionally depend on an EnvironmentObject.
    @EnvironmentObject private var entryTimer: EntryTimer

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
        DayView(DateInterval.yesterday)
                .environmentObject(entryTimer)
                .environment(\.managedObjectContext, moc)
                .background(entryTimer.theme.backgroundColor)
                .previewLayout(.sizeThatFits)
    }

}
