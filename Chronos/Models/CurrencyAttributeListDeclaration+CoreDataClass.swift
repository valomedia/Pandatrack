//
//  CurrencyAttributeListDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: CurrencyAttributeListDeclaration

@objc(CurrencyAttributeListDeclaration)
final class CurrencyAttributeListDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
