//
//  NumberAttributeChoiceDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: NumberAttributeChoiceDeclaration

@objc(NumberAttributeChoiceDeclaration)
final class NumberAttributeChoiceDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
