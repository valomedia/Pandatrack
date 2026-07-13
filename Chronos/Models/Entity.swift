//
//  Entity.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: Entity

protocol Entity: Hashable {
    associatedtype FetchRequestResultType: NSFetchRequestResult

    // MARK: - Static properties

    static var entityName: String { get }

    // MARK: - Class methods

    static func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription?

    static func makeFetchRequest() -> NSFetchRequest<FetchRequestResultType>

    // MARK: - Properties

    var primitiveTimestamp: Date? { get set }

    var timestamp: Date { get set }

}
