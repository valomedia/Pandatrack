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

            }
        }
                .onAppear { entryTimer.startTimer() }
                .onDisappear { entryTimer.stopTimer() }
    }

    /// The timer for the currently running entry.
    ///
    @EnvironmentObject
    private var entryTimer: EntryTimer

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
    static let context = PersistenceController.preview?.container.viewContext

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static let entryTimer: EntryTimer? = {
        guard let context = context else {
            return nil
        }
        let project = try? Set(context.fetch(Project.makeFetchRequest())).first { $0.name == "Private" }
        let entryTimer = EntryTimer()
        _ = entryTimer.track(Entry(context, name: "Take over the world", start: Date(), project: project))
        return entryTimer
    }()

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        if let context = context, let entryTimer = entryTimer {
            ContentView()
                    .environment(\.managedObjectContext, context)
                    .environmentObject(entryTimer)
        }
    }
}
