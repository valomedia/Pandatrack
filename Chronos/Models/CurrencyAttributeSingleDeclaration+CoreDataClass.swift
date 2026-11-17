//
//  CurrencyAttributeSingleDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: CurrencyAttributeSingleDeclaration

@objc(CurrencyAttributeSingleDeclaration)
final class CurrencyAttributeSingleDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
