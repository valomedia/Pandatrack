//
//  URLAttributeSingleRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: URLAttributeSingleRelationship

@objc(URLAttributeSingleRelationship)
final class URLAttributeSingleRelationship: NSManagedObject, AttributeSingleValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
