//
//  DateIntervalPicker.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-06.
//
//

import Foundation
import SwiftUI


// MARK: DateIntervalPicker

/// Undocumented.
///
/// - Todo: Document.
///
struct DateIntervalPicker: View {

    private enum DateIntervalPresets: String, Identifiable, CustomStringConvertible, CaseIterable {
        case sevenDays = "7D"
        case week = "W"
        case thirtyDays = "30D"
        case month = "M"
        case twelveMonths = "12M"

        var interval: DateInterval {
            switch self {
            case .sevenDays: return .sevenDays
            case .week: return .week
            case .thirtyDays: return .thirtyDays
            case .month: return .month
            case .twelveMonths: return .twelveMonths
            }
        }

        var id: String { rawValue }
        var description: String { rawValue }

    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @Binding var selection: DateInterval

    var body: some View {
        HStack {
            Button {
                selection.start -= selection.duration + 1
            } label: {
                Image(systemName: "chevron.backward")
            }
            VStack {
                HStack {
                    DatePicker(
                            "Start",
                            selection: $selection.start,
                            in: PartialRangeThrough(selection.end),
                            displayedComponents: [.date]
                    )
                            .labelsHidden()
                    Spacer()
                    Text("–")
                    Spacer()
                    DatePicker(
                            "End",
                            selection: $selection.end,
                            in: PartialRangeFrom(selection.start),
                            displayedComponents: [.date]
                    )
                            .labelsHidden()
                }
                Picker("Interval", selection: $selection) {
                    ForEach(DateIntervalPresets.allCases) { preset in
                        Text(preset.description).tag(preset.interval)
                    }
                }
                        .pickerStyle(.segmented)
            }
            Button {
                selection.start += selection.duration + 1
            } label: {
                Image(systemName: "chevron.forward")
            }
        }
                .padding(.horizontal)
    }

}


// MARK: DateIntervalPicker_Previews

class DateIntervalPicker_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        DateIntervalPicker(selection: .constant(DateInterval.yesterday)).previewLayout(.sizeThatFits)
    }

}