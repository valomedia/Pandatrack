//
//  Item+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: Item

///
/// - Todo: Document.
@objc(Item)
public class Item: NSManagedObject, Identifiable {

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
    public init(context moc: NSManagedObjectContext) {
        super.init(entity: Self.entity(in: moc)!, insertInto: moc)
    }

    ///
    /// - Todo: Document.
    /// - Parameters:
    ///   - moc:
    ///   - name:
    public init(_ moc: NSManagedObjectContext, name: String) {
        super.init(entity: Self.entity(in: moc)!, insertInto: moc)
        primitiveName = name
    }
}
