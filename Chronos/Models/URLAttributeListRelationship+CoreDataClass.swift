//
//  URLAttributeListRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: URLAttributeListRelationship

@objc(URLAttributeListRelationship)
final class URLAttributeListRelationship: NSManagedObject, AttributeListValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
