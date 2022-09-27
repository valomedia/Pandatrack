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
            Section(header: Text("Project")) {
                HStack {
                    Label("Project", systemImage: "at")
                    Spacer()
                    Text(entry.project?.name ?? "No project")
                }
                        .accessibilityElement(children: .combine)
                if let parent = entry.project?.parent {
                    HStack {
                        Label("Folder", systemImage: "folder")
                        Spacer()
                        Text(parent.name)
                    }
                            .accessibilityElement(children: .combine)
                }
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(entry.theme.name)
                            .padding(4)
                            .foregroundColor(entry.theme.foregroundColor)
                            .background(entry.theme.backgroundColor)
                            .cornerRadius(4)
                }
                        .accessibilityElement(children: .combine)
            }
            if !entry.tags.isEmpty {
                Section(header: Text("Tags")) {
                    ForEach(entry.tags.map(\.path).sorted(), id: \.self) {
                        Label($0, systemImage: "number")
                    }
                }
            }
            if let history = entry.project?.entries, !history.isEmpty {
                Section(header: Text("History")) {
                    ForEach(history.sorted(by: \.start)) { entry in
                        Button(action: { /* Todo */ }) {
                            HStack {
                                EntryView(entry: entry)
                                Image(systemName: "play.fill")
                            }
                        }
                                .foregroundColor(entry.theme.foregroundColor)
                                .listRowBackground(entry.theme.backgroundColor)
                    }
                }
            }
        }
                .navigationTitle(entry.name)
                .toolbar {
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                }
                .sheet(isPresented: $isPresentingEditView) {
                    NavigationView {
                        EntryDetailEditView(entry: $entry)
                                .navigationTitle(entry.name)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Cancel") {
                                            isPresentingEditView = false
                                            entry.managedObjectContext?.rollback()
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Done") {
                                            isPresentingEditView = false

                                            do {
                                                try entry.managedObjectContext?.save()
                                            } catch let error as NSError {
                                                // TODO: Replace this implementation with code to handle the error.
                                                fatalError("Unresolved error \(error), \(error.userInfo)")
                                            }
                                        }
                                    }
                                }
                    }
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
        try! EntryDetailView(
                entry: .constant(
                        Set(PersistenceController.preview!.container.viewContext.fetch(Entry.makeFetchRequest()))
                                .first { $0.name == "Take over the world!" }!))
                .environmentObject(ChronosEnvironment.preview!)
    }
}