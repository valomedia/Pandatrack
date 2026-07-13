//
//  StringAttributeSingleRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: StringAttributeSingleRelationship

@objc(StringAttributeSingleRelationship)
final class StringAttributeSingleRelationship: NSManagedObject, AttributeSingleValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
