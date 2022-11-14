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

    var entryTimerView: some View {
        EntryTimerView(editAction: editAction)
                .onTapGesture { isPresentingTodayView = true }
    }

    var body: some View {
        TabView {
            VStack(spacing: 0) {
                EntriesTab()
                entryTimerView
            }
                    .tabItem {
                        Label("Entries", systemImage: "timer")
                    }
            VStack(spacing: 0) {
                ProjectsTab()
                entryTimerView
            }
                    .tabItem {
                        Label("Projects", systemImage: "at")
                    }
        }
                .onAppear(perform: entryTimer.startTimer)
                .onDisappear(perform: entryTimer.stopTimer)
                .onChange(of: phase) { phase in
                    if phase == .inactive {
                        env.save()
                    }
                }
                .sheet(isPresented: $isPresentingTodayView) {
                    TodayView(editAction: editAction)
                            .background(env.theme.backgroundColor)
                            .foregroundColor(env.theme.foregroundColor)
                }
                .modal(entryTimer.entry?.name, isPresented: $isPresentingEditView) {
                    EntryDetailEditView(entry: entryTimer.entry)
                }
    }

    /// Whether the sheet showing the full EntryTimerView is visible.
    ///
    @State private var isPresentingTodayView = false

    /// Whether the sheet showing the EntryTimerDetailEditView is visible.
    ///
    @State private var isPresentingEditView = false

    /// The timer for the currently running entry.
    ///
    @ObservedObject private var entryTimer = EntryTimer.shared

    @EnvironmentObject private var env: ChronosEnvironment

    @Environment(\.scenePhase)
    private var phase

    @Environment(\.managedObjectContext)
    private var moc

    // MARK: - Methods

    private func editAction() {
        isPresentingTodayView = false
        isPresentingEditView = true
    }

}


// MARK: ContentView_Previews

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
                .environment(\.managedObjectContext, moc)
                .environmentObject(env)
    }

}
