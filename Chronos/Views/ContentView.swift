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
                .modal(env, title: entryTimer.entry?.name, isPresented: $isPresentingEditView) {
                    if let entry = Binding<Entry>($entryTimer.entry) {
                        EntryDetailEditView(entry: entry)
                    } else {
                        NoContentView(
                                title: "There Is Nothing Here",
                                headline: "No Entry Is Running",
                                caption: "Please start a new entry to begin editing.")
                    }
                }
    }

    var entryTimerView: some View {
        EntryTimerView(editAction: editAction)
                .onTapGesture { isPresentingTodayView = true }
    }

    /// The timer for the currently running entry.
    ///
    @ObservedObject private var entryTimer = EntryTimer.shared

    @EnvironmentObject private var env: ChronosEnvironment

    @Environment(\.scenePhase)
    private var phase

    /// Whether the sheet showing the full EntryTimerView is visible.
    ///
    @State private var isPresentingTodayView = false

    /// Whether the sheet showing the EntryTimerDetailEditView is visible.
    ///
    @State private var isPresentingEditView = false

    @Environment(\.managedObjectContext)
    private var moc

    // MARK: - Methods

    private func editAction() {
        isPresentingTodayView = false
        isPresentingEditView = true
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
                .environment(\.managedObjectContext, moc)
                .environmentObject(env)
    }
}
