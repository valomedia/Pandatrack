//
//  BuiltinAttributeDeclaration+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: BuiltinAttributeDeclaration

/// Undocumented.
///
/// - Todo: Document.
///
@objc(BuiltinAttributeDeclaration)
public class BuiltinAttributeDeclaration: NSManagedObject, AttributeDeclaration {

    // MARK: - Life cycle methods

    @available(*, unavailable)
    public init() {
        fatalError("init() has not been implemented")
    }

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public init(context moc: NSManagedObjectContext) {
        super.init(entity: Self.entity(in: moc)!, insertInto: moc)
    }

}
