//
//  CurrencyAttributeChoiceDeclaration+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: CurrencyAttributeChoiceDeclaration

/// Undocumented.
///
/// - Todo: Document.
///
@objc(CurrencyAttributeChoiceDeclaration)
final class CurrencyAttributeChoiceDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    @available(*, unavailable)
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
