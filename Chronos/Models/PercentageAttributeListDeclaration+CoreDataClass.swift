//
//  PercentageAttributeListDeclaration+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: PercentageAttributeListDeclaration

/// Undocumented.
///
/// - Todo: Document.
///
@objc(PercentageAttributeListDeclaration)
final class PercentageAttributeListDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
