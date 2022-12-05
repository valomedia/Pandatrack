//
//  TrackungSheet.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: TrackingSheet

/// Undocumented.
///
/// - Todo: Document.
///
struct TrackingSheet: View {

    // MARK: - Properties

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                    .fill(entryTimer.theme.backgroundColor)
            VStack {
                PomodoroTimerView(pomodoroTimer: entryTimer.pomodoroTimer, theme: entryTimer.theme)
                TabView(selection: $tabViewSelection) {
                    DayView(DateInterval.yesterday).tag(DateInterval.yesterday)
                    DayView(DateInterval.today).tag(DateInterval.today)
                }
                        .tabViewStyle(PageTabViewStyle())
                EntryTimerView(editAction: editAction)
            }
        }
                .foregroundColor(entryTimer.theme.foregroundColor)
                .navigationBarTitleDisplayMode(.inline)
    }

    @State private var tabViewSelection = DateInterval.today

    @Environment(\.managedObjectContext)
    private var moc

    @EnvironmentObject private var entryTimer: EntryTimer

    // MARK: - Functions

    /// A function to call to start editing the current Entry.
    ///
    let editAction: ()->Void

}


// MARK: TrackingSheet_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct TrackingSheet_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        TrackingSheet(editAction: {})
                .environmentObject(entryTimer)
                .environment(\.managedObjectContext, moc)
                .background(entryTimer.theme.backgroundColor)
                .previewLayout(.sizeThatFits)
    }

}
