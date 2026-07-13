//
//  NumberAttributeListDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: NumberAttributeListDeclaration

@objc(NumberAttributeListDeclaration)
final class NumberAttributeListDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
