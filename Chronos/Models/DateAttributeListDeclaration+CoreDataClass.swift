//
//  DateAttributeListDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: DateAttributeListDeclaration

@objc(DateAttributeListDeclaration)
final class DateAttributeListDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
