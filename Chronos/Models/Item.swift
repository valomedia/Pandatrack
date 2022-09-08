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

///
/// - Todo: Document.
public protocol Item: Identifiable {

    // MARK: - Properties

    ///
    /// - Todo: Document.
    var id: UUID { get set }

    ///
    /// - Todo: Document.
    var name: String { get set }

    ///
    /// - Todo: Document.
    var timestamp: Date { get set }

}
