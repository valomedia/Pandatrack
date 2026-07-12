//
//  NumberAttributeChoiceRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: NumberAttributeChoiceRelationship

@objc(NumberAttributeChoiceRelationship)
final class NumberAttributeChoiceRelationship: NSManagedObject, AttributeChoiceValueRelationship {

    // MARK: - Life cycle methods

    @available(*, unavailable)
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
