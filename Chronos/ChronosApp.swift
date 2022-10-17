//
//  ChronosApp.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-07.
//
//

import Foundation
import SwiftUI


// MARK: ChronosApp

/// Undocumented.
///
/// - Todo: Document.
///
@main
struct ChronosApp: App {

    // MARK: - Life cycle methods

    init() {
        #if DEBUG
        var injectionBundlePath = "/Applications/InjectionIII.app/Contents/Resources"
        #if targetEnvironment(macCatalyst)
        injectionBundlePath = "\(injectionBundlePath)/macOSInjection.bundle"
        #elseif os(iOS)
        injectionBundlePath = "\(injectionBundlePath)/iOSInjection.bundle"
        #endif
        Bundle(path: injectionBundlePath)?.load()
        #endif
    }

    // MARK: - Properties

    var body: some Scene {
        WindowGroup {
            #if DEBUG && targetEnvironment(simulator)
            ContentView_Previews.previews
            #else
            ChronosView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(chronosEnvironment)
            #endif
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let persistenceController = PersistenceController.shared

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @StateObject private var chronosEnvironment = ChronosEnvironment(PersistenceController.shared.container.viewContext)

}
