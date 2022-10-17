//
//  URLAttributeSingleDeclaration+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: URLAttributeSingleDeclaration

/// Undocumented.
///
/// - Todo: Document.
///
@objc(URLAttributeSingleDeclaration)
public class URLAttributeSingleDeclaration: BuiltinAttributeDeclaration {

    // MARK: - Life cycle methods

    @available(*, unavailable)
    public init() {
        fatalError("init() has not been implemented")
    }

    @available(*, unavailable)
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @available(*, unavailable)
    public override init(context moc: NSManagedObjectContext) {
        super.init(entity: Self.entity(in: moc)!, insertInto: moc)
    }

}
