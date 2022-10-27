//
//  SampleData.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-25.
//
//

import Foundation
import CoreData


// MARK: Entry

extension Entry {

    // MARK: + sampleData

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///     - projects:
    ///     - tags:
    @discardableResult
    @SetBuilder<Entry>
    static func sampleData(for context: NSManagedObjectContext) throws -> Set<Entry> {
        let projects = try Set(context.fetch(Project.makeFetchRequest()))
        let tags = try Set(context.fetch(Tag.makeFetchRequest()))

        let theDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: Date.yesterday)!

        Entry(
                context,
                name: "Thingamaboob development",
                interval: DateInterval(
                        start: Calendar.current.date(bySettingHour: 09, minute: 00, second: 00, of: theDayBefore)!,
                        end:   Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: theDayBefore)!),
                project: projects.first { $0.name == "Transmogrifier"})
        Entry(
                context,
                name: "Work on top secret gizmo",
                interval: DateInterval(
                        start: Calendar.current.date(bySettingHour: 13, minute: 00, second: 00, of: theDayBefore)!,
                        end:   Calendar.current.date(bySettingHour: 15, minute: 00, second: 00, of: theDayBefore)!),
                project: projects.first { $0.name == "Transmogrifier" },
                tags: tags.filter { $0.name == "Secret" })
        Entry(
                context,
                name: "Conference call",
                interval: DateInterval(
                        start: Calendar.current.date(bySettingHour: 15, minute: 30, second: 00, of: theDayBefore)!,
                        end:   Calendar.current.date(bySettingHour: 16, minute: 45, second: 00, of: theDayBefore)!),
                project: projects.first { $0.name == "Tailspin Toys" },
                tags: tags.filter { $0.name == "Client Work" })
        Entry(
                context,
                name: "Meeting of the secret illuminati",
                interval: DateInterval(
                        start: Calendar.current.date(bySettingHour: 19, minute: 30, second: 00, of: theDayBefore)!,
                        end:   Calendar.current.date(bySettingHour: 22, minute: 30, second: 00, of: theDayBefore)!),
                project: projects.first { $0.name == "Froobnicator" },
                tags: tags.filter { $0.name == "Secret" })
        Entry(
                context,
                name: "Conference call",
                interval: DateInterval(
                        start: Calendar.current.date(bySettingHour: 10, minute: 00, second: 00, of: Date.yesterday)!,
                        end:   Calendar.current.date(bySettingHour: 11, minute: 00, second: 00, of: Date.yesterday)!),
                project: projects.first { $0.name == "Froobnicator" },
                tags: tags.filter { $0.name == "Secret" || $0.name == "Client Work" })
        Entry(
                context,
                name: "Start development",
                interval: DateInterval(
                        start: Calendar.current.date(bySettingHour: 11, minute: 00, second: 00, of: Date.yesterday)!,
                        end:   Calendar.current.date(bySettingHour: 13, minute: 00, second: 00, of: Date.yesterday)!),
                project: projects.first { $0.name == "Chronos" })
        Entry(
                context,
                name: "Touch base",
                interval: DateInterval(
                        start: Calendar.current.date(bySettingHour: 14, minute: 00, second: 00, of: Date.yesterday)!,
                        end:   Calendar.current.date(bySettingHour: 14, minute: 15, second: 00, of: Date.yesterday)!),
                project: projects.first { $0.name == "Tailspin Toys" },
                tags: tags.filter { $0.name == "Client Work" })
        Entry(
                context,
                name: "Take over the world",
                interval: DateInterval(
                        start: Calendar.current.date(bySettingHour: 18, minute: 00, second: 00, of: Date.yesterday)!,
                        end:   Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: Date.yesterday)!),
                project: projects.first { $0.name == "Private" })
    }

}


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
    static func sampleData(for context: NSManagedObjectContext) -> Set<Project> {
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


// MARK: Tag

extension Tag {

    // MARK: + sampleData

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @discardableResult
    @SetBuilder<Tag>
    static func sampleData(for context: NSManagedObjectContext) -> Set<Tag> {
        Tag(context, name: "Secret") {
            Tag(context, name: "Foo")
            Tag(context, name: "Bar")
            Tag(context, name: "Baz")
        }
        Tag(context, name: "Client Work")
    }

}