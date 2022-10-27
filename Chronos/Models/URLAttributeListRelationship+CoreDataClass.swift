//
//  URLAttributeListRelationship+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: URLAttributeListRelationship

/// Undocumented.
///
/// - Todo: Document.
///
@objc(URLAttributeListRelationship)
final class URLAttributeListRelationship: NSManagedObject, AttributeListValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
