//
//  Item.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: Item

/// Undocumented.
///
/// - Todo: Document.
///
protocol Item: Identifiable {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var id: UUID { get set }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var name: String { get set }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var timestamp: Date { get set }

}
