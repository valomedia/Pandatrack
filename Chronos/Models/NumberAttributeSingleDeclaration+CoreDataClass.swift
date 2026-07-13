//
//  NumberAttributeSingleDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: NumberAttributeSingleDeclaration

@objc(NumberAttributeSingleDeclaration)
final class NumberAttributeSingleDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
