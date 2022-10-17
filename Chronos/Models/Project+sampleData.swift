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

extension Project {

    // MARK: + sampleData

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameter context:
    ///
    @discardableResult
    @SetBuilder<Project>
    public class func sampleData(for context: NSManagedObjectContext) -> Set<Project> {
        Project(context, name: "Business") {
            Project(context, name: "ACME", theme: .indigo) {
                Project(context, name: "Transmogrifier")
                Project(context, name: "Froobnicator")
            }
            Project(context, name: "Contoso", theme: .orange) {
                Project(context, name: "Chronos")
            }
            Project(context, name: "Tailspin Toys", theme: .purple)
        }
        Project(context, name: "Private")
    }

}