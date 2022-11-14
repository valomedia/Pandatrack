//
//  Entity.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation
import CoreData


// MARK: Entity

/// Undocumented.
///
/// - Todo: Document.
///
protocol Entity: Hashable {
    associatedtype FetchRequestResultType: NSFetchRequestResult

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var entityName: String { get }

    // MARK: - Class methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - managedObjectContext:
    /// - Returns:
    ///
    static func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription?

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Returns:
    ///
    static func makeFetchRequest() -> NSFetchRequest<FetchRequestResultType>

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var primitiveTimestamp: Date? { get set }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var timestamp: Date { get set }

}
