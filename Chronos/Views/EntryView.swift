//
//  EntryView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-07.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: EntryView

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryView: View {

    // MARK: - Static properties

    private static let briefDateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.collapsesLargestUnit = true
        formatter.unitsStyle = .brief
        return formatter
    }()

    private static let fullDateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        return formatter
    }()

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        CardView(
                title: entry.name,
                theme: entry.theme,
                labels: (
                        (Label(entry.project?.name ?? "No Project", systemImage: "at"),
                                Label(
                                        Self.briefDateComponentsFormatter.string(from: entry.interval.duration) ?? "",
                                        systemImage: "hourglass")),
                        (Label(entry.project?.parent?.name ?? "", systemImage: "folder"),
                                Label(
                                        RelativeDateTimeFormatter.formatter.string(for: entry.end) ?? "",
                                        systemImage: "clock"))))
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Entry")
                .accessibilityValue(entry.name)
    }

    /// The Entry being shown.
    ///
    let entry: Entry
}

// MARK: EntryView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        try! EntryView(
                entry: Set(PersistenceController.preview!.container.viewContext.fetch(Entry.makeFetchRequest()))
                        .first { $0.name == "Take over the world!" }!)
                .previewLayout(.fixed(width: 400, height: 60))
    }
}
