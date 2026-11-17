//
//  CurrencyAttributeChoiceDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: CurrencyAttributeChoiceDeclaration

@objc(CurrencyAttributeChoiceDeclaration)
final class CurrencyAttributeChoiceDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    @available(*, unavailable)
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
