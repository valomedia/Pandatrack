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

    var body: some View {
        VStack {
            HStack {
                Text(entryTimer.entry?.name ?? "Not Tracking")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                Spacer()
                HStack {
                    Button(action: editAction) {
                        Image(systemName: "slider.horizontal.3")
                    }
                            .foregroundColor(env.theme.foregroundColor)
                            .accessibilityLabel("Edit running timer")
                    if entryTimer.entry != nil {
                        // Have to wrap the function in a lambda, because Swift is picky about unused return values.
                        Button(action: { env.stopEntry() }) {
                            Image(systemName: "stop.fill")
                        }
                                .foregroundColor(env.theme.foregroundColor)
                                .accessibilityLabel("Stop timer")
                        // Have to wrap the function in a lambda, because Swift is picky about unused return values.
                        Button(action: { env.startEntry() }) {
                            Image(systemName: "forward.end.fill")
                        }
                                .foregroundColor(env.theme.foregroundColor)
                                .accessibilityLabel("Stop timer and start new timer")
                    } else {
                        // Have to wrap the function in a lambda, because Swift is picky about unused return values.
                        Button(action: { env.startEntry() }) {
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
                .background(env.theme.backgroundColor)
                .foregroundColor(env.theme.foregroundColor)
    }

    @EnvironmentObject
    private var env: ChronosEnvironment

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
                .environmentObject(env)
                .previewLayout(.sizeThatFits)
    }

}