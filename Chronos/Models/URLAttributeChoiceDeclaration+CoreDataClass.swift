//
//  URLAttributeChoiceDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: URLAttributeChoiceDeclaration

@objc(URLAttributeChoiceDeclaration)
final class URLAttributeChoiceDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
