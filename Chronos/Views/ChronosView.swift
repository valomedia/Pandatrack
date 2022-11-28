//
//  ChronosView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-07.
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
struct ChronosView: View {

    // MARK: - Life cycle methods

    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    // MARK: - Properties

    var body: some View {
        ContentView()
                .sheet(item: $env.errorWrapper) { wrapper in ErrorView(errorWrapper: wrapper) }
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .environmentObject(env)
                .environmentObject(entryTimer)
                .onAppear { PersistenceController.shared.container.viewContext.undoManager = env.undoManager }
                .onChange(of: phase) { phase in
                    if phase == .inactive { env.save() }
                }
    }

    @Environment(\.scenePhase)
    private var phase

    @StateObject private var env = ChronosEnvironment(PersistenceController.shared.container.viewContext)
    @StateObject private var entryTimer = EntryTimer(PersistenceController.shared.container.viewContext)

}

// MARK: ChronosView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class ChronosView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View { ChronosView() }

    // MARK: - Methods

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ChronosView_Previews.previews)
    }
    #endif

}
