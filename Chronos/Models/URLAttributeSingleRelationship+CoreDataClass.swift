//
//  URLAttributeSingleRelationship+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: URLAttributeSingleRelationship

@objc(URLAttributeSingleRelationship)
final class URLAttributeSingleRelationship: NSManagedObject, AttributeSingleValueRelationship {

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
