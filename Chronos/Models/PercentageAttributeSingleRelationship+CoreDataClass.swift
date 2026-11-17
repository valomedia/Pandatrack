//
//  PercentageAttributeSingleRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: PercentageAttributeSingleRelationship

@objc(PercentageAttributeSingleRelationship)
final class PercentageAttributeSingleRelationship: NSManagedObject, AttributeSingleValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
