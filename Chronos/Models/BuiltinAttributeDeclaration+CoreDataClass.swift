//
//  BuiltinAttributeDeclaration+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: BuiltinAttributeDeclaration

/// Undocumented.
///
/// - Todo: Document.
///
@objc(BuiltinAttributeDeclaration)
class BuiltinAttributeDeclaration: NSManagedObject, AttributeDeclaration {

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        guard !entity.isAbstract else {
            fatalError("init(entity:insertInto:) has not been implemented")
        }
        super.init(entity: entity, insertInto: context)
    }

}
