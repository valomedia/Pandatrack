//
//  URLAttributeChoiceRelationship+CoreDataClass.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: URLAttributeChoiceRelationship

@objc(URLAttributeChoiceRelationship)
final class URLAttributeChoiceRelationship: NSManagedObject, AttributeChoiceValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
