//
//  DateAttributeChoiceDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: DateAttributeChoiceDeclaration

@objc(DateAttributeChoiceDeclaration)
final class DateAttributeChoiceDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
