//
//  NSManagedObject+Identifiable.swift
//  Chronos
//

import Foundation
import CoreData


// MARK: NSManagedObject

extension NSManagedObject: @retroactive Identifiable {

    // MARK: + Identifiable

    public var id: NSManagedObjectID {
        objectID
    }

}
