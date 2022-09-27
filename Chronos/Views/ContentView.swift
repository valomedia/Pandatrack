//
//  ContentView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-06.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: ContentView

/// Undocumented.
///
/// - Todo: Document.
///
struct ContentView: View {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        VStack(spacing: 1) {
            NavigationView {
                EntriesView()
            }
            Button(action: { isPresentingTodayView = true }) {
                EntryTimerView(editAction: editAction)
                        .sheet(isPresented: $isPresentingTodayView) {
                            TodayView(editAction: editAction)
                                    .background(env.theme.backgroundColor)
                                    .foregroundColor(env.theme.foregroundColor)
                        }
                        .sheet(isPresented: $isPresentingEntryTimerDetailEditView) {
                            NavigationView {
                                // Todo
                            }
                        }
            }
        }
                .onAppear { entryTimer.startTimer() }
                .onDisappear { entryTimer.stopTimer() }
    }

    @EnvironmentObject
    private var env: ChronosEnvironment

    /// The timer for the currently running entry.
    ///
    @ObservedObject
    private var entryTimer = EntryTimer.shared

    /// Whether the sheet showing the full EntryTimerView is visible.
    ///
    @State
    private var isPresentingTodayView = false

    /// Whether the sheet showing the EntryTimerDetailEditView is visible.
    ///
    @State
    private var isPresentingEntryTimerDetailEditView = false

    @Environment(\.managedObjectContext)
    private var viewContext

    // MARK: - Methods

    private func editAction() {
        isPresentingTodayView = false
        isPresentingEntryTimerDetailEditView = true
    }
}

/// Undocumented.
///
/// - Todo: Document.
///
class ContentView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        ContentView()
                .environment(\.managedObjectContext, PersistenceController.preview!.container.viewContext)
                .environmentObject(ChronosEnvironment.preview!)
    }
}
