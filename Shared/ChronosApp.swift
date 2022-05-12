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

/**
 - Todo: Document.
 */
@main
struct ChronosApp: App {

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     */
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

    /**
     - Todo: Document.
     */
    let persistenceController = PersistenceController.shared

    /**
     - Todo: Document.
     */
    var body: some Scene {
        WindowGroup {
            #if DEBUG && targetEnvironment(simulator)
            ContentView_Previews.previews
            #else
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            #endif
        }
    }
}
