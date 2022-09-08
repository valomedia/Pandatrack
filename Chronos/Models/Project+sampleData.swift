//
//  Project+sampleData.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: Project

// MARK: + sampleData

extension Project {

    // MARK: - Class methods

    ///
    /// - Todo: Document.
    /// - Parameter context:
    @discardableResult
    @SetBuilder<Project>
    public class func sampleData(for context: NSManagedObjectContext) -> Set<Project> {
        Project(context, name: "Business") {
            Project(context, name: "ACME") {
                Project(context, name: "Transmogrifier")
                Project(context, name: "Froobnicator")
            }
            Project(context, name: "Contoso") {
                Project(context, name: "Chronos")
            }
            Project(context, name: "Tailspin Toys")
        }
        Project(context, name: "Private")
    }
}