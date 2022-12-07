//
//  ReportDetailView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation
import SwiftUI


// MARK: ReportDetailView

/// Undocumented.
///
/// - Todo: Document.
///
struct ReportDetailView: View {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var entries: [CompletedEntry]

    var body: some View {
        EntriesView("Results", entries: AnyRandomAccessCollection(entries), isPrimaryContent: true)
    }

}


// MARK: ReportDetailView_Previews

class ReportDetailView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        List {
            try! ReportDetailView(entries: moc.fetch(CompletedEntry.makeFetchRequest()).sorted(by: \.start))
                    .environment(\.managedObjectContext, moc)
                    .environmentObject(env)
        }
    }

}
