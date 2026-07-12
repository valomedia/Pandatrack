//
//  DateAttributeSingleDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: DateAttributeSingleDeclaration

@objc(DateAttributeSingleDeclaration)
final class DateAttributeSingleDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
