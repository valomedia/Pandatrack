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

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - editAction:
    ///     - compact:
    ///
    init(editAction: @escaping ()->Void, compact: Bool = false) {
        self.editAction = editAction
        self.compact = compact
    }

    // MARK: - Properties

    /// A function to call to start editing the current Entry.
    ///
    let editAction: ()->Void

    /// Whether to show a more compact version of this view.
    ///
    let compact: Bool

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(entryTimer.runningEntry?.name ?? "Not Tracking")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                Spacer()
                HStack {
                    Button(action: {
                        if entryTimer.runningEntry == nil { entryTimer.track() }
                        editAction()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                            .foregroundColor(entryTimer.theme.foregroundColor)
                            .accessibilityLabel("Edit running timer")
                    if entryTimer.runningEntry != nil {
                        // Have to wrap the function in a lambda, because Swift is picky about unused return values.
                        Button(action: { entryTimer.reset() }) {
                            Image(systemName: "stop.fill")
                        }
                                .foregroundColor(entryTimer.theme.foregroundColor)
                                .accessibilityLabel("Stop timer")
                        // Have to wrap the function in a lambda, because Swift is picky about unused return values.
                        Button(action: { entryTimer.track() }) {
                            Image(systemName: "forward.end.fill")
                        }
                                .foregroundColor(entryTimer.theme.foregroundColor)
                                .accessibilityLabel("Stop timer and start new timer")
                    } else {
                        // Have to wrap the function in a lambda, because Swift is picky about unused return values.
                        Button(action: { entryTimer.track() }) {
                            Image(systemName: "play.fill")
                        }
                                .accessibilityLabel("Start timer")
                    }
                }
                        .padding([.leading])
            }
            HStack {
                Label(entryTimer.runningEntry?.project?.name ?? "No Project", systemImage: "at")
                        .labelStyle(.leadingIcon)
                        .accessibilityLabel("Project")
                        .accessibilityValue(entryTimer.runningEntry?.project?.name ?? "None")
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
            if (!compact) {
                HStack {
                    Label(entryTimer.runningEntry?.project?.parent?.name ?? "", systemImage: "folder")
                            .labelStyle(.leadingIcon)
                            .ifNotNil(entryTimer.runningEntry?.project?.parent) { view, folder in
                                view
                                        .accessibilityLabel("Folder")
                                        .accessibilityValue(folder.name)
                            }
                            .if(entryTimer.runningEntry?.project?.parent == nil) { view in
                                view.accessibilityHidden(true)
                            }
                    Spacer()
                    Label(
                            (entryTimer.runningEntry?.start).map(Self.shortTimeDateFormatter.string(from:)) ?? "",
                            systemImage: "clock"
                    )
                            .labelStyle(.trailingIcon)
                            .ifNotNil(entryTimer.runningEntry) { view, entry in
                                view
                                        .accessibilityLabel("Running since")
                                        .accessibilityValue(Self.longTimeDateFormatter.string(from: entry.start))
                            }
                            .if(entryTimer.runningEntry == nil) { view in
                                view.accessibilityHidden(true)
                            }
                }
                        .font(.caption)
            }
        }
                .padding()
                .background(entryTimer.theme.backgroundColor)
                .foregroundColor(entryTimer.theme.foregroundColor)
    }

    @EnvironmentObject private var entryTimer: EntryTimer

}


// MARK: EntryTimerView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryTimerView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        EntryTimerView(editAction: {})
                .environmentObject(entryTimer)
                .previewLayout(.sizeThatFits)
    }

}