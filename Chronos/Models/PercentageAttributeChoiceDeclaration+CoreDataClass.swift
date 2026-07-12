//
//  PercentageAttributeChoiceDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: PercentageAttributeChoiceDeclaration

@objc(PercentageAttributeChoiceDeclaration)
final class PercentageAttributeChoiceDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
