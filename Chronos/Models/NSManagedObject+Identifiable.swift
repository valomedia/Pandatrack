//
//  NSManagedObject+Identifiable.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-14.
//
//

import Foundation
import CoreData


// MARK: NSManagedObject

extension NSManagedObject: Identifiable {

    // MARK: + Identifiable

    public var id: NSManagedObjectID {
        objectID
    }

}