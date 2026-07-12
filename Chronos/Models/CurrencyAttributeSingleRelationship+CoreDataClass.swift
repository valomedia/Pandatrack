//
//  CurrencyAttributeSingleRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: CurrencyAttributeSingleRelationship

@objc(CurrencyAttributeSingleRelationship)
final class CurrencyAttributeSingleRelationship: NSManagedObject, AttributeSingleValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
