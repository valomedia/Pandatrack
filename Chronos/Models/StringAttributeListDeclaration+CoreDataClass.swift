//
//  StringAttributeListDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: StringAttributeListDeclaration

@objc(StringAttributeListDeclaration)
final class StringAttributeListDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
