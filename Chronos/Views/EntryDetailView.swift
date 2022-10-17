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

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Todo: Add continuing existing entry
    ///
    var body: some View {
        List {
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
            if let project = entry.project {
                Section(header: Text("Project")) {
                    ProjectView(project: project)
                }
            }
            if !entry.tags.isEmpty {
                Section(header: Text("Tags")) {
                    TagsView(tags: AnyRandomAccessCollection(entry.tags.sorted(by: \.path)))
                }
            }
            if let history = entry.project?.entries, !history.isEmpty {
                Section(header: Text("History")) {
                    EntriesView(entries: AnyRandomAccessCollection(history.sorted(by: \.start)))
                }
            }
        }
                .navigationTitle(entry.name)
                .toolbar {
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                }
                .modal(env, title: entry.name, isPresented: $isPresentingEditView) {
                    EntryDetailEditView(entry: $entry)
                }
    }

    /// The Entry being shown.
    ///
    @Binding
    var entry: Entry

    @EnvironmentObject
    private var env: ChronosEnvironment

    @State
    private var isPresentingEditView = false
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
                    entry: .constant(
                            Set(moc.fetch(Entry.makeFetchRequest())).first { $0.name == "Take over the world" }!))
                    .environmentObject(env)
        }
    }
}