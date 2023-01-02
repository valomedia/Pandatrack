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
    enum Tab: String, TabBarTab {
        case entries
        case projects
        case tags
        case reports

        var image: Image {
            switch self {
            case .entries: return Image(systemName: "timer")
            case .projects: return Image(systemName: "at")
            case .tags: return Image(systemName: "number")
            case .reports: return Image(systemName: "list.clipboard")
            }
        }

        var text: Text {
            Text(rawValue.capitalized)
        }

    }

    // MARK: - Properties

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TabView(selection: $tabBarSelection) {
                    EntriesTab().tag(Tab.entries)
                    ProjectsTab().tag(Tab.projects)
                    TagsTab().tag(Tab.tags)
                    ReportsTab().tag(Tab.reports)
                }
                        .onAppear(perform: entryTimer.startTimer)
                        .onDisappear(perform: entryTimer.stopTimer)
                        .sheet(isPresented: $isPresentingTodayView) {
                            TrackingSheet(editAction: editAction)
                                    .background(entryTimer.theme.backgroundColor)
                                    .foregroundColor(entryTimer.theme.foregroundColor)
                        }
                        .modal(entryTimer.runningEntry?.name, isPresented: $isPresentingEditView) {
                            if let runningEntry = entryTimer.runningEntry {
                                EntryDetailEditView(entry: runningEntry)
                            }
                        }
                        .sheet(isPresented: $isPresentingWorkspacesView) {
                            NavigationView { MissingFeatureView().navigationTitle("Shared Workspaces") }
                        }
                EntryTimerView(editAction: editAction, compact: true)
                        .onTapGesture { isPresentingTodayView = true }
                TabBar(selection: $tabBarSelection)
            }
        }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: env.undo) { Image(systemName: "arrow.uturn.backward") }.enabled(env.canUndo)
                        Button(action: env.redo) { Image(systemName: "arrow.uturn.forward") }.enabled(env.canRedo)
                        Spacer()
                        ShareLink(item: env.shareString ?? "").enabled(env.shareString != nil)
                        Spacer()
                        Button {
                            isPresentingWorkspacesView = true
                        } label: {
                            Image(systemName: "person.crop.circle")
                        }
                        Button {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                DispatchQueue.main.async { UIApplication.shared.open(url) }
                            }
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
    }

    /// Whether the sheet showing the full EntryTimerView is visible.
    ///
    @State private var isPresentingTodayView = false

    /// Whether the sheet showing the EntryTimerDetailEditView is visible.
    ///
    @State private var isPresentingEditView = false

    /// Whether the sheet showing the WorkspacesView is visible.
    ///
    @State private var isPresentingWorkspacesView = false

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
