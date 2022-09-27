//
//  EntryTimerDetailView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: EntryTimerDetailView

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryTimerDetailView: View {

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
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                    .fill(theme.backgroundColor)
            VStack {
                if let pomodoroTimer = entryTimer.pomodoroTimer {
                    PomodoroTimerView(pomodoroTimer: pomodoroTimer, theme: theme)
                }
                Spacer()
                Text("Today")
                        .frame(alignment: .center)
                        .font(.largeTitle)
                Circle()
                        .strokeBorder(lineWidth: 24)
                Spacer()
                EntryTimerView(
                        entryTimer: entryTimer,
                        editAction: editAction,
                        startAction: startAction,
                        stopAction: stopAction)
            }
        }
                .padding()
                .foregroundColor(theme.foregroundColor)
                .navigationBarTitleDisplayMode(.inline)
    }
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
        let entryTimer = try! EntryTimer.shared.track(
                PersistenceController.preview!.container.viewContext,
                continueFrom: Set(PersistenceController.preview!.container.viewContext.fetch(Entry.makeFetchRequest()))
                        .first { $0.name == "Take over the world!" }!)
        return EntryTimerDetailView(
                editAction: {},
                startAction: {},
                stopAction: {})
                .background(entryTimer.entry?.theme.backgroundColor)
                .previewLayout(.sizeThatFits)
    }
}