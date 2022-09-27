//
//  TodayView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: TodayView

/// Undocumented.
///
/// - Todo: Document.
///
struct TodayView: View {

    // MARK: - Properties

    /// The EntryTimer being shown.
    ///
    @ObservedObject
    var entryTimer = EntryTimer.shared

    /// A function to call to start editing the current Entry.
    ///
    let editAction: ()->Void

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
                EntryTimerView(entryTimer: entryTimer, editAction: editAction)
            }
        }
                .padding()
                .foregroundColor(theme.foregroundColor)
                .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: TodayView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct TodayView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        TodayView(editAction: {})
                .environmentObject(ChronosEnvironment.preview!)
                .background(EntryTimer.shared.entry?.theme.backgroundColor)
                .previewLayout(.sizeThatFits)
    }
}