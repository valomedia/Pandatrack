//
//  PreviewProvider+entry.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: PreviewProvider

// MARK: + entry

extension PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var entry: Entry {
        try! PersistenceController.preview!.container.viewContext.fetch(Entry.makeFetchRequest()).first!
    }
}