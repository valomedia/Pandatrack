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

    private static let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    // MARK: - Properties

    /// The Entry being shown.
    ///
    @ObservedObject @ManagedEntity var entry: CompletedEntry?

    var body: some View {
        if let entry = entry {
            CardView(
                    title: entry.name,
                    labels: (
                            Label(entry.project?.name ?? "No Project", systemImage: "at"),
                            Label(TimeInterval.formatter.string(from: entry.duration) ?? "", systemImage: "hourglass"),
                            Label(entry.project?.parent?.name ?? "", systemImage: "folder"),
                            Label(Self.dateFormatter.string(for: entry.start) ?? "", systemImage: "clock"))
            )
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
