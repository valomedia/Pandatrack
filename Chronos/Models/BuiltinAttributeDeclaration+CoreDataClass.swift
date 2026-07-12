//
//  BuiltinAttributeDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: BuiltinAttributeDeclaration

@objc(BuiltinAttributeDeclaration)
class BuiltinAttributeDeclaration: NSManagedObject, AttributeDeclaration {

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        guard !entity.isAbstract else { fatalError("init(entity:insertInto:) has not been implemented") }
        super.init(entity: entity, insertInto: context)
    }

}
