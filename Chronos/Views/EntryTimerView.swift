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
struct EntryTimerView: View, KeyboardReadable {

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

    var body: some View {
        Wrapper {
            if !keyboardIsVisible {
                HStack {
                    VStack {
                        HStack {
                            Text(entryTimer.timeElapsedString)
                                    .accessibilityLabel("Duration")
                                    .accessibilityValue(entryTimer.timeElapsedAccessibilityLabel)
                                    .font(.headline)
                                    .accessibilityAddTraits(.isHeader)
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Label(entryTimer.runningEntry?.name ?? "Not Tracking", systemImage: "timer")
                                        .ifNotNil(entryTimer.runningEntry) {
                                            $0
                                                    .accessibilityLabel("Entry Name")
                                                    .accessibilityValue($1.name)
                                        }
                                        .if(entryTimer.runningEntry == nil) {
                                            $0.accessibilityHidden(true)
                                        }
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Label(entryTimer.runningEntry?.project?.name ?? "No Project", systemImage: "at")
                                        .accessibilityLabel("Project")
                                        .accessibilityValue(entryTimer.runningEntry?.project?.name ?? "None")
                                if let parent = entryTimer.runningEntry?.project?.parent {
                                    Label(parent.name, systemImage: "folder")
                                            .accessibilityLabel("Folder")
                                            .accessibilityValue(parent.name)
                                }
                                Spacer()
                            }
                        }
                                .font(.caption)
                    }
                    Spacer()
                    Button(action: entryTimer.toggle) {
                        Image(systemName: entryTimer.isRunning ? "stop.circle.fill" : "play.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                    }
                            .foregroundColor(entryTimer.theme.foregroundColor)
                            .accessibilityLabel(entryTimer.isRunning ? "Stop timer" : "Start timer")
                }
                        .frame(height: 60)
                        .padding()
                        .background(entryTimer.theme.backgroundColor)
                        .foregroundColor(entryTimer.theme.foregroundColor)
            }
        }
                .onReceive(keyboardPublisher) { newValue in
                    keyboardIsVisible = newValue
                }
    }

    @EnvironmentObject private var entryTimer: EntryTimer

    @State private var keyboardIsVisible = false

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
        EntryTimerView()
                .environmentObject(entryTimer)
                .previewLayout(.sizeThatFits)
    }

}