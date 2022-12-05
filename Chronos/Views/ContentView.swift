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

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    enum Tab: String, TabBarItem {
        case entries
        case projects
        case tags

        var image: Image {
            switch self {
            case .entries: return Image(systemName: "timer")
            case .projects: return Image(systemName: "at")
            case .tags: return Image(systemName: "number")
            }
        }

        var text: Text {
            Text(rawValue.capitalized)
        }

    }

    // MARK: - Properties

    var entryTimerView: some View {
        EntryTimerView(editAction: editAction)
                .onTapGesture { isPresentingTodayView = true }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TabView(selection: $tabBarSelection) {
                    VStack(spacing: 0) {
                        EntriesTab()
                        entryTimerView
                    }
                            .tag(Tab.entries)
                    VStack(spacing: 0) {
                        ProjectsTab()
                        entryTimerView
                    }
                            .tag(Tab.projects)
                    VStack(spacing: 0) {
                        TagsTab()
                        entryTimerView
                    }
                            .tag(Tab.tags)
                }
                        .onAppear(perform: entryTimer.startTimer)
                        .onDisappear(perform: entryTimer.stopTimer)
                        .sheet(isPresented: $isPresentingTodayView) {
                            TrackingSheet(editAction: editAction)
                                    .background(entryTimer.theme.backgroundColor)
                                    .foregroundColor(entryTimer.theme.foregroundColor)
                        }
                        .modal(entryTimer.runningEntry?.name, isPresented: $isPresentingEditView) {
                            EntryDetailEditView(entry: entryTimer.runningEntry)
                        }
                TabBar(selection: $tabBarSelection)
            }
        }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: env.undo) { Image(systemName: "arrow.uturn.backward") }.enabled(env.canUndo)
                        Button(action: env.redo) { Image(systemName: "arrow.uturn.forward") }.enabled(env.canRedo)
                        Spacer()
                    }
                }
    }

    /// Whether the sheet showing the full EntryTimerView is visible.
    ///
    @State private var isPresentingTodayView = false

    /// Whether the sheet showing the EntryTimerDetailEditView is visible.
    ///
    @State private var isPresentingEditView = false

    /// The currently selected tab.
    ///
    @State private var tabBarSelection: ContentView.Tab = .entries

    @EnvironmentObject private var env: ChronosEnvironment
    @EnvironmentObject private var entryTimer: EntryTimer

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
                .environmentObject(entryTimer)
    }

}
