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
            predicate = NSPredicate(format: "start > %@", Date.startOfToday as NSDate)
        }
        _entries = FetchRequest<CompletedEntry>(sortDescriptors: [SortDescriptor(\.start)], predicate: predicate)
    }

    // MARK: - Properties

    var body: some View {
        let totalTime: TimeInterval = entries.map(\.interval.duration).sum()
        VStack {
            Text(Self.dateFormatter.string(from: day.start))
                    .frame(alignment: .center)
                    .padding([.top, .horizontal])
                    .font(.largeTitle)
            Circle()
                    .strokeBorder(lineWidth: 24)
                    .overlay {
                        Text(TimeInterval.formatter.string(from: totalTime) ?? "")
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
                    .padding([.bottom, .horizontal])
        }
                .padding()
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
        DayView(DateInterval.yesterday)
                .environment(\.managedObjectContext, moc)
                .background(entryTimer.theme.backgroundColor)
                .previewLayout(.sizeThatFits)
    }

}
