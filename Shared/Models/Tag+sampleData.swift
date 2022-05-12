//
//  Tag+sampleData.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-12.
//
//

import Foundation
import CoreData


// MARK: Tag

// MARK: + sampleData

extension Tag {

    // MARK: - Class methods

    ///
    /// - Todo: Document.
    /// - Parameter context:
    @SetBuilder<Tag>
    public class func sampleData(for context: NSManagedObjectContext) -> Set<Tag> {
        Tag(context, name: "Secret") {
            Tag(context, name: "Foo")
            Tag(context, name: "Bar")
            Tag(context, name: "Baz")
        }
        Tag(context, name: "Client Work")
    }
}