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

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                    .fill(entryTimer.theme.backgroundColor)
            VStack {
                if let pomodoroTimer = entryTimer.pomodoroTimer {
                    PomodoroTimerView(pomodoroTimer: pomodoroTimer, theme: entryTimer.theme)
                }
                Spacer()
                Text("Today")
                        .frame(alignment: .center)
                        .font(.largeTitle)
                DayView()
                Spacer()
                EntryTimerView(editAction: editAction)
            }
        }
                .padding()
                .foregroundColor(entryTimer.theme.foregroundColor)
                .navigationBarTitleDisplayMode(.inline)
    }

    @Environment(\.managedObjectContext)
    private var moc

    @EnvironmentObject private var entryTimer: EntryTimer

    // MARK: - Functions

    /// A function to call to start editing the current Entry.
    ///
    let editAction: ()->Void

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
                .environmentObject(entryTimer)
                .environment(\.managedObjectContext, moc)
                .background(entryTimer.theme.backgroundColor)
                .previewLayout(.sizeThatFits)
    }

}
