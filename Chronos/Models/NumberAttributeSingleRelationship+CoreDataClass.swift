//
//  NumberAttributeSingleRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: NumberAttributeSingleRelationship

@objc(NumberAttributeSingleRelationship)
final class NumberAttributeSingleRelationship: NSManagedObject, AttributeSingleValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
