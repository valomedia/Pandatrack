//
//  FetchRequest+init.swift
//  Chronos
//

import Foundation
import SwiftUI
import CoreData


// MARK: FetchRequest

extension FetchRequest where Result: NSManagedObject {

    public init(predicate: NSPredicate? = nil, animation: Animation? = nil) {
        self.init(sortDescriptors: [], predicate: predicate, animation: animation)
    }

}
