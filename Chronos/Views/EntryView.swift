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
    @ObservedObject var entry: CompletedEntry

    var body: some View {
        CardView(
                labels: (
                        Label(entry.project?.name ?? "No Project", systemImage: "at"),
                        Label(TimeInterval.formatter.string(from: entry.duration) ?? "", systemImage: "hourglass"),
                        Label(entry.project?.parent?.name ?? "", systemImage: "folder"),
                        Label(Self.dateFormatter.string(for: entry.start) ?? "", systemImage: "clock"))
        ) {
            HStack {
                Text(entry.name)
                Spacer()
                Image(systemName: "play.fill").onTapGesture {
                    entryTimer.track(continueFrom: entry)
                }
            }
        }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Entry")
                .accessibilityValue(entry.name)
    }

    @EnvironmentObject private var entryTimer: EntryTimer

}


// MARK: EntryView_Previews

struct EntryView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        try! EntryView(
                entry: Set(moc.fetch(CompletedEntry.makeFetchRequest())).first { $0.name == "Take over the world" }!
        )
                .environmentObject(entryTimer)
                .previewLayout(.fixed(width: 400, height: 60))
    }
}
