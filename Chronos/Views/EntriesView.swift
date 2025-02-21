//
//  EntriesView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-07.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: EntriesView

struct EntriesView: View {

    // MARK: - Life cycle methods

    init(
            _ header: LocalizedStringKey = "Entries",
            entries: AnyRandomAccessCollection<CompletedEntry>,
            isPrimaryContentForSharing: Bool? = nil
    ) {
        self.entries = entries
        self.header = header
        self.isPrimaryContentForSharing = isPrimaryContentForSharing ?? false
    }

    // MARK: - Properties

    /// The Content for the Section footer.
    ///
    let header: LocalizedStringKey

    /// Whether this EntriesView has the content that should be made available in the main ShareLink.
    ///
    let isPrimaryContentForSharing: Bool

    /// The Entries being shown by this View.
    ///
    let entries: AnyRandomAccessCollection<CompletedEntry>

    var body: some View {
        Section {
            ForEach(entries) { entry in
                NavigationLink(destination: EntryDetailView(entry: entry)) {
                    EntryView(entry: entry)
                }
                        .foregroundColor(entry.theme.foregroundColor)
                        .listRowBackground(entry.theme.backgroundColor)
                        .swipeActions(edge: .leading) {
                            Button {
                                entryTimer.track(continueFrom: entry)
                            } label: {
                                Label("Continue", systemImage: "play.fill")
                            }
                                    .tint(.green)
                        }
            }
                    .onDelete(perform: deleteEntries)
        } header: {
            Text(header)
        } footer: {
            HStack {
                Spacer()
                ShareLink(item: shareString)
            }
        }
                .onAppear { env.shareString = isPrimaryContentForSharing ? shareString : env.shareString }
                .onDisappear { env.shareString = isPrimaryContentForSharing ? nil : env.shareString }
    }

    /// The entries as CSV for sharing.
    ///
    private var shareString: String {
        entries.map { entry in
            [
                ISO8601DateFormatter.formatter.string(from: entry.start),
                ISO8601DateFormatter.formatter.string(from: entry.end),
                entry.name,
                entry.project?.path ?? ""
            ]
                    .map { "\"" + $0.replacingOccurrences(of: "\"", with: "\"\"") + "\"" }
                    .joined(separator: ",")
        }
                .joined(separator: "\n")
    }

    @Environment(\.managedObjectContext)
    private var moc

    @EnvironmentObject private var env: ChronosEnvironment
    @EnvironmentObject private var entryTimer: EntryTimer

    // MARK: - Methods

    private func deleteEntries(offsets: IndexSet) {
        offsets
                .map { entries[AnyIndex($0)] }
                .forEach(moc.delete)
    }

}


// MARK: EntriesView_Previews

class EntriesView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List {
                try! EntriesView(
                        "Entries",
                        entries: AnyRandomAccessCollection(
                                moc.fetch(CompletedEntry.makeFetchRequest()).sorted(by: \.start))
                )
                        .environment(\.managedObjectContext, moc)
                        .environmentObject(env)
                        .environmentObject(entryTimer)
            }
        }
    }

}
