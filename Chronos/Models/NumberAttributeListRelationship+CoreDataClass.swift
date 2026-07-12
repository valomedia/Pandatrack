//
//  NumberAttributeListRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: NumberAttributeListRelationship

@objc(NumberAttributeListRelationship)
final class NumberAttributeListRelationship: NSManagedObject, AttributeListValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
