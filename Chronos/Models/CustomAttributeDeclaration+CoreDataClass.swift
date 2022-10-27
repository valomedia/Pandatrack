//
//  CustomAttributeDeclaration+CoreDataClass.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: CustomAttributeDeclaration

/// Undocumented.
///
/// - Todo: Document.
///
@objc(CustomAttributeDeclaration)
final class CustomAttributeDeclaration: NSManagedObject, AttributeDeclaration, Node {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public static let pathSeparator: String = "."

    // MARK: - Life cycle methods

    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
