//
//  EntryDetailView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-07.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: EntryDetailView

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryDetailView: View {

    // MARK: - Static properties

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        VStack {
            Text(entry.name)
            Text("Item at \(entry.timestamp, formatter: EntryDetailView.dateFormatter)")
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let entry: Entry
}

// MARK: EntryDetailView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryDetailView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        if let entry = try? PersistenceController.preview!.container.viewContext.fetch(Entry.makeFetchRequest()).first {
            EntryDetailView(entry: entry)
        }
    }
}