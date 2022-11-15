//
//  EntryDetailView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-07.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: EntryDetailView

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryDetailView: View {

    // MARK: - Static properties

    private static let positionalDateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    private static let fullDateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full
        return formatter
    }()

    private static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    private static let longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        return formatter
    }()

    // MARK: - Properties

    /// The Entry being shown.
    ///
    @ObservedObject @ManagedEntity var entry: Entry?

    var body: some View {
        List {
            if let entry = entry {
                Section(header: Text("Time Entry")) {
                    Button(action: { env.startEntry(continueFrom: entry) }) {
                        HStack {
                            Label("Continue", systemImage: "timer")
                                    .font(.headline)
                                    .foregroundColor(.accentColor)
                            Spacer()
                            Text(RelativeDateTimeFormatter.formatter.string(for: entry.end) ?? "")
                                    .accessibilityHidden(true)
                            Image(systemName: "play.fill")
                                    .padding(.leading)
                        }
                    }
                            // Work around for a bug in XCode 14 (FB11278036).
                            .buttonStyle(.borderless)
                    HStack {
                        Label("Start Time", systemImage: "clock")
                        Spacer()
                        Text(Self.shortDateFormatter.string(from: entry.start))
                    }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Start Time")
                            .accessibilityValue(Self.longDateFormatter.string(from: entry.start))
                    if let end = entry.end {
                        HStack {
                            Label("End Time", systemImage: "clock")
                            Spacer()
                            Text(Self.shortDateFormatter.string(from: end))
                        }
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel("End Time")
                                .accessibilityValue(Self.longDateFormatter.string(from: end))
                    }
                    if
                            let duration = entry.interval.duration,
                            let durationString = Self.positionalDateComponentsFormatter.string(from: duration),
                            entry.end != nil {
                        HStack {
                            Label("Duration", systemImage: "hourglass")
                            Spacer()
                            Text(durationString)
                        }
                                .accessibilityElement(children: .combine)
                    }
                }
                        .onTapGesture { isPresentingEditView = true }
            }
            Section(header: Text("Project")) {
                EntryProjectEditView(project: $entry[\.project])
            }
            Section(header: Text("Tags")) {
                EntryTagsEditView(tags: $entry.entity[\.tags] ?? [])
            }
            if let history = entry?.project?.entries, !history.isEmpty {
                Section(header: Text("History")) {
                    EntriesView(entries: AnyRandomAccessCollection(history.sorted(by: \.start).reversed()))
                }
            }
            Section {
                Button(role: .destructive, action: { isPresentingConfirmationDialog = true }) {
                    HStack {
                        Spacer()
                        Text("Delete Entry")
                        Spacer()
                    }
                }
            }
        }
                .navigationTitle(entry?.name ?? "")
                .toolbar {
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                }
                .modal(entry?.name, isPresented: $isPresentingEditView) {
                    EntryDetailEditView(entry: entry)
                }
                .confirmationDialog(
                        "Are you sure you want to delete this Entry?",
                        isPresented: $isPresentingConfirmationDialog,
                        titleVisibility: .visible
                ) {
                    Button("Delete Entry", role: .destructive) { entry.map(moc.delete) }
                }
    }

    @EnvironmentObject private var env: ChronosEnvironment

    @State private var isPresentingEditView = false
    @State private var isPresentingConfirmationDialog = false

    @Environment(\.managedObjectContext)
    private var moc

}

// MARK: EntryDetailView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryDetailView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        NavigationView {
            try! EntryDetailView(
                    entry: Set(moc.fetch(Entry.makeFetchRequest())).first { $0.name == "Take over the world" })
                    .environment(\.managedObjectContext, moc)
                    .environmentObject(env)
        }
    }
}