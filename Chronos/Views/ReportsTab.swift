//
//  ReportsTab.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation
import SwiftUI


// MARK: ReportsTab

/// Undocumented.
///
/// - Todo: Document.
///
struct ReportsTab: View {

    // MARK: - Properties

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Interval") {
                        DatePicker("Start", selection: $interval.start, displayedComponents: [.date])
                        DatePicker("End", selection: $interval.end, displayedComponents: [.date])
                        DateIntervalPicker("Preset", selection: $interval)
                    }
                    Section("Filter") {
                        TreePicker(entity: $project) { ProjectView(project: project, compact: true) }
                        TreePicker(entity: $tag) { TagView(tag: tag) }
                    }
                    Section("Results") {
                        ReportView(interval: interval, project: project, tag: tag)
                    }
                }
            }
                    .navigationTitle("Reports")
        }
    }

    @State private var interval: DateInterval = .yesterday
    @State @ManagedEntity private var project: Project?
    @State @ManagedEntity private var tag: Tag?

}


// MARK: - ReportsTab_Previews

class ReportsTab_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        ReportsTab().environment(\.managedObjectContext, moc)
    }

}