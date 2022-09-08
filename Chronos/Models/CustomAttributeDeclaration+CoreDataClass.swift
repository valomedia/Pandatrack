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

///
/// - Todo: Document.
@objc(CustomAttributeDeclaration)
public final class CustomAttributeDeclaration: NSManagedObject, AttributeDeclaration, Node {


    // MARK: - Static properties

    public static let pathSeparator: String = "."

}
