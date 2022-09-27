//
//  EntryTimerView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: EntryTimerView

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryTimerView: View {

    // MARK: - Static properties

    private static let shortTimeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    private static let longTimeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .long
        return formatter
    }()

    // MARK: - Properties

    /// The EntryTimer being shown.
    ///
    @ObservedObject
    var entryTimer = EntryTimer.shared

    /// A function to call to start editing the current Entry.
    ///
    let editAction: ()->Void

    /// A function to start a new Entry.
    ///
    let startAction: ()->Void

    /// A function to call to write out the Entry when the timer is stopped.
    ///
    let stopAction: ()->Void

    /// The Theme to use.
    ///
    var theme: Theme {
        entryTimer.entry?.theme ?? Theme.none
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        VStack {
            HStack {
                Text(entryTimer.entry?.name ?? "Not Tracking")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                Spacer()
                HStack {
                    if entryTimer.entry != nil {
                        Button(action: editAction) {
                            Image(systemName: "slider.horizontal.3")
                        }
                                .foregroundColor(theme.foregroundColor)
                                .accessibilityLabel("Edit running timer")
                        Button(action: stopAction) {
                            Image(systemName: "stop.fill")
                        }
                                .foregroundColor(theme.foregroundColor)
                                .accessibilityLabel("Stop timer")
                        Button(action: {
                            stopAction()
                            startAction()
                        }) {
                            Image(systemName: "forward.end.fill")
                        }
                                .foregroundColor(theme.foregroundColor)
                                .accessibilityLabel("Stop timer and start new timer")
                    } else {
                        // Starting a stopped timer will automatically enter edit mode.
                        Button(action: startAction) {
                            Image(systemName: "play.fill")
                        }
                                .accessibilityLabel("Start timer")
                    }
                }
                        .padding([.leading])
            }
            Spacer()
            VStack {
                HStack {
                    Label(entryTimer.entry?.project?.name ?? "No Project", systemImage: "at")
                            .labelStyle(.leadingIcon)
                            .accessibilityLabel("Project")
                            .accessibilityValue(entryTimer.entry?.project?.name ?? "None")
                    Spacer()
                    if
                            let timeElapsedString = entryTimer.timeElapsedString,
                            let timeElapsedAccessibilityLabel = entryTimer.timeElapsedAccessibilityLabel {
                        Label(timeElapsedString, systemImage: "hourglass")
                                .labelStyle(.trailingIcon)
                                .accessibilityLabel("Duration")
                                .accessibilityValue(timeElapsedAccessibilityLabel)
                    }
                }
                        .font(.caption)
                Spacer()
                HStack {
                    Label(entryTimer.entry?.project?.parent?.name ?? "", systemImage: "folder")
                            .labelStyle(.leadingIcon)
                            .ifNotNil(entryTimer.entry?.project?.parent?.name) {
                                $0
                                        .accessibilityLabel("Folder")
                                        .accessibilityValue($1)
                            }
                            .if(entryTimer.entry?.project?.parent == nil) {
                                $0.accessibilityHidden(true)
                            }
                    Spacer()
                    if let start = entryTimer.entry?.start {
                        Label(Self.shortTimeDateFormatter.string(from: start), systemImage: "clock")
                                .labelStyle(.trailingIcon)
                                .accessibilityLabel("Running since")
                                .accessibilityValue(Self.longTimeDateFormatter.string(from: start))
                    }
                }
                        .font(.caption)
            }
        }
                .frame(height: 60)
                .padding()
    }
}

// MARK: EntryTimerDetailView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryTimerDetailView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        let _ = try! EntryTimer.shared.track(
                PersistenceController.preview!.container.viewContext,
                continueFrom: Set(PersistenceController.preview!.container.viewContext.fetch(Entry.makeFetchRequest()))
                        .first { $0.name == "Take over the world!" }!)
        EntryTimerView(editAction: {}, startAction: {}, stopAction: {})
    }
}