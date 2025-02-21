//
//  Tree.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-08-22.
//
//

import Foundation
import CoreData


// MARK: Tree

protocol Tree: Node, NSFetchRequestResult {

    // MARK: - Static methods

    static func makeFetchRequest() -> NSFetchRequest<Self>

    // MARK: - Life cycle methods

    init(_ moc: NSManagedObjectContext, name: String, parent: Self?, _ children: () -> Set<Self>?)

    // MARK: - Properties

    var parent: Self? { get set }

    var children: Set<Self> { get set }

}

extension Tree {

    // MARK: + build

    static func build(_ moc: NSManagedObjectContext, fromPath path: String) -> Self {
        let fetchRequest = Self.makeFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "parent == nil")
        return path.components(separatedBy: Self.pathSeparator).reduce { result, element in
            (try? (result?.children ?? Set(moc.fetch(fetchRequest))).first { $0.name == element })
                    ?? Self(moc, name: element, parent: result) { nil }
        }
    }

}
