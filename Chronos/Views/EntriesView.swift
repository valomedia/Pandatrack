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

/// Undocumented.
///
/// - Todo: Document.
///
struct EntriesView: View {

    // MARK: - Properties

    /// The Entries being shown by this View.
    ///
    let entries: AnyRandomAccessCollection<CompletedEntry>

    /// Whether this EntriesView has the content that should be made available in the main ShareLink.
    ///
    let sharable : Bool

    var body: some View {
        ForEach(entries) { entry in
            NavigationLink(destination: EntryDetailView(entry: entry)) { EntryView(entry: entry) }
                    .foregroundColor(entry.theme.foregroundColor)
                    .listRowBackground(entry.theme.backgroundColor)
        }
                .onDelete(perform: deleteEntries)
                .if(sharable) { view in
                    view
                            .onAppear { env.shareString = shareString }
                            .onDisappear { env.shareString = nil }
                }
    }

    @Environment(\.managedObjectContext)
    private var moc

    @EnvironmentObject private var env: ChronosEnvironment

    private var shareString: String {
        "start,end,name,project\n"
                + entries
                        .map { entry in
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

    // MARK: - Methods

    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            offsets
                    .map { entries[AnyIndex($0)] }
                    .forEach(moc.delete)
        }
    }

}


// MARK: EntriesView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class EntriesView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List {
                try! EntriesView(
                        entries: AnyRandomAccessCollection(
                                        moc.fetch(CompletedEntry.makeFetchRequest()).sorted(by: \.start)),
                        sharable: false
                )
                        .environment(\.managedObjectContext, moc)
                        .environmentObject(env)
            }
        }
    }

}
