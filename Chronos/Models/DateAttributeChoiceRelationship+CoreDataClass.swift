//
//  DateAttributeChoiceRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: DateAttributeChoiceRelationship

@objc(DateAttributeChoiceRelationship)
final class DateAttributeChoiceRelationship: NSManagedObject, AttributeChoiceValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
