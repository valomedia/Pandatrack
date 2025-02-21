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

struct ReportsTab: View {

    // MARK: - Properties

    var body: some View {
        NavigationView {
            VStack {
                DateIntervalPicker(selection: $interval)
                if (Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day == 0) {
                    DayView(interval: interval)
                } else {
                    ReportView(interval: interval)
                }
            }
                    .navigationTitle("Reports")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }

    @State private var interval: DateInterval = .today

}


// MARK: - ReportsTab_Previews

class ReportsTab_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        ReportsTab().environment(\.managedObjectContext, moc)
    }

}
