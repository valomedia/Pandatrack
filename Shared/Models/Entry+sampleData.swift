//
//  Entry+sampleData.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-12.
//
//

import Foundation
import SwiftUI
import CoreData


// MARK: Entry

// MARK: + sampleData

extension Entry {

    // MARK: - Class methods

    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///     - projects:
    ///     - tags:
    @discardableResult
    @SetBuilder<Entry>
    public class func sampleData(for context: NSManagedObjectContext) throws -> Set<Entry> {
        let projects = try Set(context.fetch(Project.makeFetchRequest()))
        let tags = try Set(context.fetch(Tag.makeFetchRequest()))

        Entry(
                context,
                name: "Thingamaboob development",
                interval: DateInterval(
                        start: Date(iso8601DateString: "2022-01-10T09:00:00Z")!,
                        end: Date(iso8601DateString: "2022-01-10T12:00:00Z")!),
                project: projects.first { $0.name == "Transmogrifier"})
        Entry(
                context,
                name: "Work on top secret gizmo",
                interval: DateInterval(
                        start: Date(iso8601DateString: "2022-01-10T13:00:00Z")!,
                        end: Date(iso8601DateString: "2022-01-10T15:00:00Z")!),
                project: projects.first { $0.name == "Transmogrifier" },
                tags: tags.filter { $0.name == "Secret" })
        Entry(
                context,
                name: "Conference call",
                interval: DateInterval(
                        start: Date(iso8601DateString: "2022-01-10T15:30:00Z")!,
                        end: Date(iso8601DateString: "2022-01-10T16:45:00Z")!),
                project: projects.first { $0.name == "Tailspin Toys" },
                tags: tags.filter { $0.name == "Client Work" })
        Entry(
                context,
                name: "Meeting of the secret illuminati",
                interval: DateInterval(
                        start: Date(iso8601DateString: "2022-01-10T19:30:00Z")!,
                        end: Date(iso8601DateString: "2022-01-10T22:30:00Z")!),
                project: projects.first { $0.name == "Froobnicator" },
                tags: tags.filter { $0.name == "Secret" })
        Entry(
                context,
                name: "Conference call",
                interval: DateInterval(
                        start: Date(iso8601DateString: "2022-01-11T10:00:00Z")!,
                        end: Date(iso8601DateString: "2022-01-11T11:00:00Z")!),
                project: projects.first { $0.name == "Froobnicator" },
                tags: tags.filter { $0.name == "Secret" || $0.name == "Client Work" })
        Entry(
                context,
                name: "Start development",
                interval: DateInterval(
                        start: Date(iso8601DateString: "2022-01-11T11:00:00Z")!,
                        end: Date(iso8601DateString: "2022-01-11T13:00:00Z")!),
                project: projects.first { $0.name == "Chronos" })
        Entry(
                context,
                name: "Touch base",
                interval: DateInterval(
                        start: Date(iso8601DateString: "2022-01-11T14:00:00Z")!,
                        end: Date(iso8601DateString: "2022-01-11T14:15:00Z")!),
                project: projects.first { $0.name == "Tailspin Toys" },
                tags: tags.filter { $0.name == "Client Work" })
        Entry(
                context,
                name: "Take over the world",
                interval: DateInterval(
                        start: Date(iso8601DateString: "2022-01-11T18:00:00Z")!,
                        end: Date(iso8601DateString: "2022-01-11T21:00:00Z")!),
                project: projects.first { $0.name == "Private" })
    }
}