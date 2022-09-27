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

/// Undocumented.
///
/// - Todo: Document.
///
struct EntryDetailEditView: View {

    // MARK: - Static properties

    private static let abbreviatedDateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    // MARK: - Properties

    /// The Entry being modified.
    ///
    @Binding
    var entry: Entry

    var body: some View {
        Form {
            Section(header: Text("Time entry")) {
                TextField("Name", text: $entry.name)
                        .multilineTextAlignment(.leading)
                DatePicker("Start", selection: $entry.interval.start, displayedComponents: [.date, .hourAndMinute])
                DatePicker("End", selection: $entry.interval.end, displayedComponents: [.date, .hourAndMinute])
                HStack {
                    Slider(value: $entry.interval.duration, in: 5*60...4*60*60, step: 5*60)
                    Spacer()
                    Text(
                            String(
                                    format: "%dh %02dm",
                                    Int(entry.interval.duration / 60 / 60),
                                    Int(entry.interval.duration) / 60 % 60))
                            .font(.system(.body, design: .monospaced))
                }
                        .accessibilityHidden(true)
            }
        }
    }
}

// MARK: EntryDetailEditView_Previews

/// Undocumented.
///
/// - Todo: Document
///
struct EntryDetailEditView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        NavigationView {
            try! EntryDetailEditView(
                    entry: .constant(
                            Set(PersistenceController.preview!.container.viewContext.fetch(Entry.makeFetchRequest()))
                                    .first { $0.name == "Take over the world!" }!))
        }
    }
}
