//
//  CurrencyAttributeChoiceRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: CurrencyAttributeChoiceRelationship

@objc(CurrencyAttributeChoiceRelationship)
final class CurrencyAttributeChoiceRelationship: NSManagedObject, AttributeChoiceValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
