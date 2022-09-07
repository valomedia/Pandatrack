//
//  EntryView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-07.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: EntryView

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryView: View {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        Text(entry.name)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let entry: Entry
}

// MARK: EntryView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        if let entry = try? PersistenceController.preview!.container.viewContext.fetch(Entry.makeFetchRequest()).first {
            EntryView(entry: entry)
                    .previewLayout(.fixed(width: 400, height: 60))
        }
    }
}
