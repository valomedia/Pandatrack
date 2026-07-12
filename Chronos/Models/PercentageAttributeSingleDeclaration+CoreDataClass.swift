//
//  PercentageAttributeSingleDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: PercentageAttributeSingleDeclaration

@objc(PercentageAttributeSingleDeclaration)
final class PercentageAttributeSingleDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
