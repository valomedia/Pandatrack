//
//  StringAttributeSingleDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: StringAttributeSingleDeclaration

@objc(StringAttributeSingleDeclaration)
final class StringAttributeSingleDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
