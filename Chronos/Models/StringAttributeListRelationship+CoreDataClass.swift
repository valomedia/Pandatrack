//
//  StringAttributeListRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: StringAttributeListRelationship

@objc(StringAttributeListRelationship)
final class StringAttributeListRelationship: NSManagedObject, AttributeListValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
