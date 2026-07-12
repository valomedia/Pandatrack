//
//  URLAttributeListDeclaration+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: URLAttributeListDeclaration

@objc(URLAttributeListDeclaration)
final class URLAttributeListDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
