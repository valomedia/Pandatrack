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
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @EnvironmentObject
    var environment: ChronosEnvironment
}

// MARK: ContentView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class ChronosView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        if let context = PersistenceController.preview?.container.viewContext {
            ChronosView()
                    .environment(\.managedObjectContext, context)
                    .environmentObject(ChronosEnvironment.shared)
        }
    }

    // MARK: - Methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ChronosView_Previews.previews)
    }
    #endif
}
