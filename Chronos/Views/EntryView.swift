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

    // MARK: - Properties

    /// The Entry being shown.
    ///
    @ObservedObject @ManagedEntity var entry: CompletedEntry?

    var body: some View {
        if let entry = entry {
            CardView(
                    title: entry.name,
                    theme: entry.theme,
                    labels: (
                            (Label(entry.project?.name ?? "No Project", systemImage: "at"),
                                    Label(
                                            DateComponentsFormatter.fullTimeFormatter.string(from: entry.interval.duration)
                                                    ?? "",
                                            systemImage: "hourglass")),
                            (Label(entry.project?.parent?.name ?? "", systemImage: "folder"),
                                    Label(
                                            RelativeDateTimeFormatter.formatter.string(for: entry.end) ?? "",
                                            systemImage: "clock"))))
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Entry")
                    .accessibilityValue(entry.name)
        } else {
            EmptyView()
        }
    }

}


// MARK: EntryView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        try! EntryView(entry: Set(moc.fetch(CompletedEntry.makeFetchRequest())).first { $0.name == "Take over the world" }!)
                .previewLayout(.fixed(width: 400, height: 60))
    }
}
