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

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    enum DateIntervalPresets: String, Identifiable, CustomStringConvertible, CaseIterable {
        case today = "Today"
        case yesterday = "Yesterday"
        case thisWeek = "This Week"
        case lastWeek = "Last Week"
        case lastSevenDays = "Last 7 Days"
        case thisMonth = "This Month"
        case lastMonth = "Last Month"
        case lastThirtyDays = "Last 30 Days"
        case thisYear = "This Year"
        case lastYear = "Last Year"

        /// Undocumented.
        ///
        /// - Todo: Document.
        ///
        var interval: DateInterval {
            switch self {
            case .today: return .today
            case .yesterday: return .yesterday
            case .thisWeek: return .thisWeek
            case .lastWeek: return .lastWeek
            case .lastSevenDays: return .lastSevenDays
            case .thisMonth: return .thisMonth
            case .lastMonth: return .lastMonth
            case .lastThirtyDays: return .lastThirtyDays
            case .thisYear: return .thisYear
            case .lastYear: return .lastYear
            }
        }

        var id: String { rawValue }
        var description: String { rawValue }

    }

    // MARK: - Static properties

    // MARK: - Static methods

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - titleKey:
    ///     - selection:
    ///
    init(_ titleKey: LocalizedStringKey, selection: Binding<DateInterval>) {
        self.titleKey = titleKey
        _selection = selection
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var titleKey: LocalizedStringKey

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @Binding var selection: DateInterval

    var body: some View {
        Picker(titleKey, selection: $selection) {
            ForEach(DateIntervalPresets.allCases) { preset in
                Text(preset.description).tag(preset.interval)
            }
            //Text(DateIntervalPresets.today.description).tag(DateIntervalPresets.today.interval)
            //Text(DateIntervalPresets.yesterday.description).tag(DateIntervalPresets.yesterday.interval)
            //Text(DateIntervalPresets.thisWeek.description).tag(DateIntervalPresets.thisWeek.interval)
            //Text(DateIntervalPresets.lastWeek.description).tag(DateIntervalPresets.lastWeek.interval)
            //Text(DateIntervalPresets.lastSevenDays.description).tag(DateIntervalPresets.lastSevenDays.interval)
            //Text(DateIntervalPresets.thisMonth.description).tag(DateIntervalPresets.thisMonth.interval)
            //Text(DateIntervalPresets.lastMonth.description).tag(DateIntervalPresets.lastMonth.interval)
            //Text(DateIntervalPresets.lastThirtyDays.description).tag(DateIntervalPresets.lastThirtyDays.interval)
            //Text(DateIntervalPresets.thisYear.description).tag(DateIntervalPresets.thisYear.interval)
            //Text(DateIntervalPresets.lastYear.description).tag(DateIntervalPresets.lastYear.interval)
        }
    }

}


// MARK: DateIntervalPicker_Previews

class DateIntervalPicker_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        DateIntervalPicker("Interval", selection: .constant(DateInterval.yesterday)).previewLayout(.sizeThatFits)
    }

}