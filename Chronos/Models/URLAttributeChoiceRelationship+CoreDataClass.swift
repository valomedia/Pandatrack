//
//  URLAttributeChoiceRelationship+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: URLAttributeChoiceRelationship

/// Undocumented.
///
/// - Todo: Document.
///
@objc(URLAttributeChoiceRelationship)
final class URLAttributeChoiceRelationship: NSManagedObject, AttributeChoiceValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
