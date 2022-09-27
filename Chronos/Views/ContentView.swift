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
            Button(action: { isPresentingEntryTimerView = true }) {
                EntryTimerView(
                        editAction: editAction,
                        startAction: startAction,
                        stopAction: stopAction)
                        .background(entryTimer.entry?.project?.theme?.backgroundColor)
                        .foregroundColor(entryTimer.entry?.project?.theme?.foregroundColor)
                        .sheet(isPresented: $isPresentingEntryTimerView) {
                            EntryTimerDetailView(
                                    editAction: editAction,
                                    startAction: startAction,
                                    stopAction: stopAction)
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

    /// The timer for the currently running entry.
    ///
    @ObservedObject
    private var entryTimer = EntryTimer.shared

    /// Whether the sheet showing the full EntryTimerView is visible.
    ///
    @State
    private var isPresentingEntryTimerView = false

    /// Whether the sheet showing the EntryTimerDetailEditView is visible.
    ///
    @State
    private var isPresentingEntryTimerDetailEditView = false

    @Environment(\.managedObjectContext)
    private var viewContext

    // MARK: - Methods

    private func startAction() {
        entryTimer.track(Entry(viewContext, name: "", start: Date()))

        do {
            try viewContext.save()
        } catch let error as NSError {
            // TODO: Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this
            // function in a shipping application, although it may be useful during development.
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }

    private func stopAction() {
        entryTimer.reset()

        do {
            try viewContext.save()
        } catch let error as NSError {
            // TODO: Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this
            // function in a shipping application, although it may be useful during development.
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }

    private func editAction() {
        isPresentingEntryTimerView = false
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
    }
}
