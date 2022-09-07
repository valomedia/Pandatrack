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
        }
    }

    @Environment(\.managedObjectContext)
    private var viewContext
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
        if let context = PersistenceController.preview?.container.viewContext {
            ContentView().environment(\.managedObjectContext, context)
        }
    }
}
