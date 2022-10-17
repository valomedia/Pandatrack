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

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        ContentView()
                .sheet(item: $env.errorWrapper) { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
    }

    /// The timer for the currently running entry.
    ///
    @ObservedObject private var entryTimer = EntryTimer.shared

    @EnvironmentObject private var env: ChronosEnvironment

    @Environment(\.scenePhase)
    private var phase

}

// MARK: ContentView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class ChronosView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        ChronosView()
                .environment(\.managedObjectContext, moc)
                .environmentObject(env)
    }

    // MARK: - Methods

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ChronosView_Previews.previews)
    }
    #endif

}
