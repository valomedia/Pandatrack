//
//  NSFetchRequest+init.swift
//  Chronos
//

import Foundation
import CoreData

// MARK: NSFetchRequest

extension NSFetchRequest {

    // MARK: + init

    @objc
    convenience init(entityName: String? = nil, predicate: NSPredicate? = nil) {
        if let entityName = entityName {
            self.init(entityName: entityName)
        } else {
            self.init()
        }
        if let predicate = predicate {
            self.predicate = predicate
        }
    }

}
