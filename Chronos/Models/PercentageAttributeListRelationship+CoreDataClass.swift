//
//  PercentageAttributeListRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: PercentageAttributeListRelationship

@objc(PercentageAttributeListRelationship)
final class PercentageAttributeListRelationship: NSManagedObject, AttributeListValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
