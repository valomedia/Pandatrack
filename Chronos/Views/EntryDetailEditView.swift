//
//  EntryDetailEditView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-27.
//
//

import Foundation
import SwiftUI


// MARK: EntryDetailEditView

struct EntryDetailEditView<EntryType: Entry>: View {

    // MARK: - Properties

    /// The Entry being modified.
    ///
    @ObservedObject var entry: EntryType

    var body: some View {
        Form(content: {
            Section(header: Text("Time entry")) {
                TextField("Name", text: $entry.name)
                        .multilineTextAlignment(.leading)
                DatePicker(
                        "Start",
                        selection: $entry.start,
                        in: PartialRangeThrough((entry as? CompletedEntry)?.end ?? Date()),
                        displayedComponents: [.date, .hourAndMinute])
                if let entry = entry as? CompletedEntry {
                    let end = Binding(
                            get: { entry.end },
                            set: { newValue in entry.end = newValue })
                    let duration = Binding(
                            get: { entry.duration },
                            set: { newValue in entry.duration = newValue })
                    DatePicker(
                            "End",
                            selection: end,
                            in: PartialRangeFrom(entry.start),
                            displayedComponents: [.date, .hourAndMinute])
                    HStack {
                        Slider(value: duration, in: 5 * 60...4 * 60 * 60, step: 5 * 60)
                        Spacer()
                        Text(
                                String(
                                        format: "%dh %02dm",
                                        Int(entry.duration / 60 / 60),
                                        Int(entry.duration) / 60 % 60))
                                .font(.system(.body, design: .monospaced))
                    }
                            .accessibilityHidden(true)
                }
            }
            Section(header: Text("Project")) {
                EntryProjectEditView(project: $entry.project)
            }
            Section(header: Text("Tags")) {
                EntryTagsEditView(tags: $entry.tags)
            }
        })
    }

}


// MARK: EntryDetailEditView_Previews

struct EntryDetailEditView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            try! EntryDetailEditView(
                    entry: Set(moc.fetch(Entry.makeFetchRequest())).first { $0.name == "Take over the world" }!)
        }
    }

}
