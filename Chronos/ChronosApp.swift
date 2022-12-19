//
//  ChronosApp.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-07.
//
//

import Foundation
import CoreData
import SwiftUI


// MARK: ChronosApp

/// Undocumented.
///
/// - Todo: Document.
///
@main
struct ChronosApp: App {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
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

        Settings.namePreference = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
        Settings.identifierPreference = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
        Settings.versionPreference = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        Settings.buildPreference = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }

    // MARK: - Properties

    var body: some Scene {
        WindowGroup {
            #if DEBUG && targetEnvironment(simulator)
            ChronosView_Previews.previews
            #else
            ChronosView()
            #endif
        }
    }

}
