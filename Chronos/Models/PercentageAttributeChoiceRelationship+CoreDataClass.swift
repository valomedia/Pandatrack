//
//  PercentageAttributeChoiceRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: PercentageAttributeChoiceRelationship

@objc(PercentageAttributeChoiceRelationship)
final class PercentageAttributeChoiceRelationship: NSManagedObject, AttributeChoiceValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
